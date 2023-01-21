import mongoose from 'mongoose';

import BookedFavor from "../models/bookedFavor.js";
import Rating from "../models/rating.js";
import User from "../models/user.js";
import Post from '../models/post.js';
import Leaderboard from '../models/leaderboard.js';

import { createJsonPost } from './utilities/jsonCreators.js';

/**
 * 
 * @param {*} request contaning the query parameter about the page
 * @param {*} response contaning a maximum number of posts equals to LIMIT value, the current page, the total number of pages
 */
export const getBookedFavors = async (request, response) => {
    const { page } = request.query;
    try {
        const LIMIT = 4;
        const pageStartIndex = (Number(page) - 1) * LIMIT;
        console.log(request.userId)
        // Count BookedFavor documents where the user is either the provider or the caller.
        const filter = { $or: [{ providerId: request.userId }, { callerId: request.userId }] };
        const total = await BookedFavor.countDocuments(filter);

        // Find BookedFavor documents where the user is either the provider or the caller.
        // Sort BookedFavor documents from newest to oldest order, pass -1 as the parameter of sort().
        // To skip the BookedFavor documents before the current page start index.
        const bookedFavors = await BookedFavor.find(filter).sort({ _id: -1 }).limit(LIMIT).skip(pageStartIndex);



        // For each BookedFavor document, get the post associated and the other user profile data.
        // Return the BookedFavor document with side information about the other user.
        var newBookedFavors = []
        for (const document of bookedFavors) {
            // If the BookedFavor document is not terminated (i.e. the favor has been executed) and the post exists, then fill with side information.
            if (!document.isTerminated && document.post) {
                var post = await Post.findById(document.post.toHexString());
                if (post) {
                    var otherUserId;
                    var otherUserType;
                    if(document.providerId == request.userId){
                        otherUserId = document.callerId;
                        otherUserType = 'caller';
                    }
                    else {
                        otherUserId = document.providerId;
                        otherUserType = 'provider';
                    }
                    var otherUser = await User.findById(otherUserId);
                    //console.log(otherUser);
                    if (otherUser) {
                        var newDocument = { ...document._doc, post: await createJsonPost(post, otherUser,otherUserType) };
                        newBookedFavors = [...newBookedFavors, newDocument];
                    }
                }
            }
        }
        if (newBookedFavors.length == 0)
            console.log(">>> getBookedFavors: There are no booked favors!")

        response.status(200).json({ data: newBookedFavors, currentPage: Number(page), numberOfPages: Math.ceil(total / LIMIT) });
        console.log(">>> getBookedFavors: Sent "+ bookedFavors.length +" bookedFavors to client.");
        //console.log(">>> getBookedFavors, booked favors are the following: ",bookedFavors)
    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}




export const completeFavor = async (request, response) => {
    const { id } = request.params;
    try {
        const bookedFavorId = id;
        const bookedFavor = await BookedFavor.findById(bookedFavorId);

        console.log(">>> completeFavor: Marking the booked favor as terminated")

        if (bookedFavor.providerId != request.userId)
            return response.status(400).json({ message: "Cannot mark a favor as completed if you are not the provider" });

        bookedFavor.isTerminated = true;

        await BookedFavor.findByIdAndUpdate(bookedFavorId, bookedFavor, { new: true });
        console.log(">>> completeFavor: Marked the booked favor as terminated")
        return response.status(200).json({ message: bookedFavorId + " marked as completed" });

    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}

export const rateFavor = async (request, response) => {
    const { id } = request.params;
    const { rating } = request.body;
    try {
        const bookedFavorId = id;

        const existingRating = await Rating.findOne({ $and: [{ favor: bookedFavorId }, { user: request.userId }] })

        if (existingRating)
            return response.status(400).send(`User already rated this favor with id: ${bookedFavorId}`);

        if (!request.userId)
            return response.status(401).json({ message: 'Unauthenticated' });

        if (!mongoose.Types.ObjectId.isValid(bookedFavorId))
            return response.status(400).send(`No booked favor with id: ${bookedFavorId}`);

        const userWhosRating = await User.findById(request.userId);
        const bookedFavorToRate = await BookedFavor.findById(bookedFavorId);

        if (request.userId != bookedFavorToRate.providerId && request.userId != bookedFavorToRate.callerId)
            return response.status(400).json({ message: "Cannot rate other people's favor!" });


        const newRating = new Rating({ rating: rating, user: userWhosRating._doc, favor: bookedFavorToRate });
        await newRating.save();
        console.log(">>> rateFavor: Inserted new rating", newRating);

        const { providerId, callerId } = bookedFavorToRate;

        const ratedUserId = request.userId == providerId ? callerId : providerId;

        console.log(">>> rateFavor: User who is rating is:", request.userId);
        console.log(">>> rateFavor: User who is receiving rating is:", ratedUserId);
        await updateUserAverageRating(ratedUserId);


        const isRatedUserProvider = ratedUserId == providerId;
        await bookedFavorToRate.populate('post')
        await updateLeaderboard(ratedUserId, isRatedUserProvider, bookedFavorToRate.post.location, rating);

        return response.status(200).json({ message: 'Favor rated successfully.' });

    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}


const updateUserAverageRating = async (ratedUserId) => {
    Rating.find().populate({
        path: 'favor',
        match: { $or: [{ providerId: ratedUserId }, { callerId: ratedUserId }] },
    })
        .exec(async function (err, ratings) {
            if (err) {
                throw exception;
            } else {
                //console.log(">>> rateFavorFound: The following ratings having as provider or caller the just rated user -> ", ratings);
                var totalRatings = 0
                var found_ratings = [];
                for (const rating of ratings) {
                    if (rating.user._id != ratedUserId) {
                        totalRatings++;
                        found_ratings = [...found_ratings, rating.rating];
                    }
                }
                const totalScore = found_ratings.reduce((acc, rating) => acc + rating);
                const newAverageRating = totalScore / totalRatings;

                //console.log(totalScore)
                //console.log(newAverageRating)

                const ratedUser = await User.findById(ratedUserId)
                ratedUser.averageRatings = newAverageRating;
                await User.findByIdAndUpdate(ratedUserId, ratedUser, { new: true });
                console.log(">>> rateFavor: Updated averageRatings of user", ratedUser.email);
            }
        });
}


const updateLeaderboard = async (ratedUserId, isRatedUserProvider, favorLocation, rating) => {
    var ratedUserType = ''
    if (isRatedUserProvider)
        ratedUserType = 'provider';
    else
        ratedUserType = 'caller';

    const leaderboard = await Leaderboard.findOne({ userType: ratedUserType, location: favorLocation });

    if (leaderboard) { //If leaderboard already exists, increment the score value by summing rating

        const filter = { userType: ratedUserType, location: favorLocation, 'users.user': ratedUserId }

        const existingUserInLeaderboard = await Leaderboard.findOne(filter);
        if (existingUserInLeaderboard) {
            const update = { $inc: { 'users.$.score': rating } }
            await Leaderboard.findOneAndUpdate(filter, update, { new: true });
        }
        else {
            const filter = { userType: ratedUserType, location: favorLocation }
            const newElement = { user: ratedUserId, score: rating };
            await Leaderboard.findOneAndUpdate(filter, { $push: { users: newElement } });
        }
        console.log(">>> rateFavor: Score in Leaderboard updated successfully!")


        const filterForSort = { userType: ratedUserType, location: favorLocation }
        const leaderboard = await Leaderboard.findOneAndUpdate(filterForSort);
        const { users } = leaderboard;
        const sortedUsers = users.sort((a, b) => b.score - a.score);
        await leaderboard.updateOne({ $set: { users: sortedUsers } });
        console.log(">>> rateFavor: Leaderboard sorted and updated successfully!")

    }
    else {
        //If the leaderboard doesn't exist, then create a new one with the user as first value of users array
        const newLeaderboard = new Leaderboard({ location: favorLocation, userType: ratedUserType, users: [{ user: ratedUserId, score: rating }] });
        await newLeaderboard.save();
        console.log(">>> rateFavor: Created new leaderboard!")
    }

}


