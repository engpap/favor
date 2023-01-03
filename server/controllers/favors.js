import mongoose from 'mongoose';

import BookedFavor from "../models/bookedFavor.js";
import Rating from "../models/rating.js";
import User from "../models/user.js";
import Post from '../models/post.js';
import Leaderboard from '../models/leaderboard.js';


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

        const total = await BookedFavor.countDocuments({});

        // To return all documents in a collection, omit parameter of find().  
        // To sort posts from newest to oldest order, pass -1 as the parameter of sort().
        // To skip the posts before the current page start index.
        const bookedFavors = await BookedFavor.find().sort({ _id: -1 }).limit(LIMIT).skip(pageStartIndex);

        var newBookedFavors = []
        for (const document of bookedFavors) {
            if (!document.isTerminated && document.post) {
                console.log(document.post.toHexString())
                var post = await Post.findById(document.post.toHexString());
                if(post){
                    var user = await User.findById(post._doc.creatorId);
                    if(user){ //TODO: MAKE IT BETTER, MORE SOLID
                        var jsonPost = { ...post._doc, name: user.name, surname: user.surname, profilePicture: user.profilePicture, bio: user.bio, averageStars: user.averageStars, rankingPosition: 1, rankingLocation: 'to_define' }
                        var newDocument = { ...document._doc, post: { ...jsonPost } }
                        newBookedFavors = [...newBookedFavors, newDocument]
                    }
                }
            }
        }
        if(newBookedFavors.length==0)
            console.log(">>> getBookedFavors: There are no booked favors!")

        response.status(200).json({ data: newBookedFavors, currentPage: Number(page), numberOfPages: Math.ceil(total / LIMIT) });
        console.log(">>> getBookedFavors: Sent bookedFavors to client.");
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
            return response.status(400).send(`User alreasy rated this favor with id: ${bookedFavorId}`);

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
        updateUserAverageRating(ratedUserId);

        const isRatedUserProvider =request.userId == providerId ? true : false;
        //updateLeaderboard(ratedUserId,isRatedUserProvider,bookedFavorToRate.post.location,rating);

        return response.status(200).json({ message: 'Favor rated successfully.' });

    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}


const updateUserAverageRating = (ratedUserId) => {
    Rating.find().populate({
        path: 'favor',
        match: { $or: [{ providerId: ratedUserId }, { callerId: ratedUserId }] },
    })
        .exec(async function (err, ratings) {
            if (err) {
                throw exception;
            } else {
                console.log(">>> rateFavorFound: The following ratings having as provider or caller the just rated user -> ", ratings);
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
                console.log(" rateFavor: Updated averageRatings of user", ratedUser.email);
            }
        });
}


const updateLeaderboard = async (ratedUserId, isRatedUserProvider, favorLocation, rating) =>{
    var ratedUserType = ''
    if(isRatedUserProvider)
        ratedUserType = 'provider';
    else
        ratedUserType = 'caller';

    const leaderboard = await Leaderboard.find({userType: ratedUserType, location: favorLocation });
    console.log("--->",leaderboard)
    /*if(leaderboard) //Leaderboard already exists
        const users = leaderboard.users;
        for(const user of users)
            if(user._id == ratedUserId)
                user.score = user.score + rating;
    else
        console.log("ciao")*/
}