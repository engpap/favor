import mongoose from 'mongoose';
import BookedFavor from '../models/bookedFavor.js';
import Post from '../models/post.js';
import User from '../models/user.js';
import axios from 'axios';
import FormData from 'form-data';

import { PROVIDER, CALLER, ADMIN, USER_TYPES } from '../constants/userTypes.js';
import { FAVOR_CATEGORIES } from '../constants/favorCategories.js'
import { LOCATIONS } from '../constants/locations.js'

import { createJsonPost } from './utilities/jsonCreators.js';

export const createPost = async (req, res) => {
    const { userType, favorStartTime, availabilityStartTime, availabilityEndTime, description } = req.body;
    console.log(userType, favorStartTime, availabilityStartTime, availabilityStartTime)

    try {
        // Check if post fields respects the user type
        if (userType == PROVIDER) {
            if (favorStartTime) {
                console.log("Provider is trying to create a post but 'favorStartTime' is not null!")
                return res.status(400).json({ message: "Provider cannot have favorStartTime value" });
            }
        }
        else if (userType == CALLER) {
            if (availabilityStartTime || availabilityEndTime) {
                console.log("Caller is trying to create a post but 'availabilityStartTime' and 'availabilityEndTime' are not null!")
                return res.status(400).json({ message: "Caller cannot have availabilityStartTime and availabilityEndTime values" });
            }
        }
        else {
            console.log("Trying to create a post but userType is neither caller not provider!")
            return res.status(400).json({ message: "Post creator should be a CALLER or a PROVIDER" });
        }

        console.log("Check on userType for Post creation is successfully passed!")

        // Use Sightengine API to moderate description text
        const data = new FormData();
        data.append('text', description);
        data.append('lang', 'en');
        data.append('opt_countries', 'us,gb,fr');
        data.append('mode', 'standard');
        data.append('api_user', '194920429');
        data.append('api_secret', process.env.SIGHTENGINE_SECRET_API);

        try {
            console.log('>>> createPost: Sending request to Sightengine...');
            const apiResponse = await axios({
                url: 'https://api.sightengine.com/1.0/text/check.json',
                method: 'post',
                data: data,
                headers: data.getHeaders()
            })
            if (apiResponse?.data?.profanity?.matches.length) { //if profanity.matches array has a length grater than 0, then some inappropriate data has been found
                console.log("Sightengine API response", apiResponse?.data);
                return res.status(409).json({ message: error.message });
            }
            else {
                console.log('>>> createPost: Description does not contain inappropriate data');
            }

        } catch (error) {
            return res.status(400).json({ message: "Post description contains inappropriate data" });
        }

        console.log('>>> createPost: Creating post...');
        const newPost = new Post({ ...req.body, creatorId: req.userId, createdAt: new Date().toISOString() });
        console.log(newPost);

        await newPost.save();
        console.log('>>> createPost: Post created!');
        var user = await User.findById(newPost.creatorId);

        res.status(201).json(await createJsonPost(newPost, user, userType));

    } catch (error) {
        console.log(error.message);
        res.status(409).json({ message: error.message });
    }
}


/**
 * 
 * @param {*} request contaning the query parameter about the page
 * @param {*} response contaning a maximum number of posts equals to LIMIT value, the current page, the total number of pages
 */
export const getPosts = async (request, response) => {
    const { page,userType } = request.query;
    try {
        console.log("-------> ",page);
        const LIMIT = 4;
        const pageStartIndex = (Number(page) - 1) * LIMIT;

        const userTypeSearchQuery_RegExp = new RegExp(userType, 'i');
        console.log(">>> getPosts: RegExp of userType searchquery is " + userTypeSearchQuery_RegExp)
        
        // Filter by userType and toHide field
        const filter = { $and: [{ userType:userTypeSearchQuery_RegExp }, { toHide: false }] };
        const total = await Post.countDocuments(filter);
        
        // To return all documents in a collection, omit parameter of find().  
        // To sort posts from newest to oldest order, pass -1 as the parameter of sort().
        // To skip the posts before the current page start index.
        const posts = await Post.find(filter).sort({ _id: -1 }).limit(LIMIT).skip(pageStartIndex);

        //TODO: calcola il rankingPosition in maniera dinamica e restituisce la location ranking
        console.log("here:> ",posts.length)
        console.log(">>> getPosts: Updating posts with users data...");
        var newPosts = []
        for (const document of posts) {
            if(!document.toHide){
                var user = await User.findById(document.creatorId);
                if (user) {
                    var newDocument = await createJsonPost(document, user, document.userType)
                    newPosts = [...newPosts, newDocument]
                }
            }
        }

        response.status(200).json({ data: newPosts, currentPage: Number(page), numberOfPages: Math.ceil(total / LIMIT) });
        console.log(">>> getPosts: Sent "+newPosts.length+" posts to client");
        //console.log(">>> getPosts: There are the posts:\n",newPosts);
    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}

/**
 * 
 * @param {*} request containing as parameter the id of the post the client wants to retrieve
 * @param {*} response containing the requested post
 
export const getPost = async (request, response) => {
    const { id } = request.params;
    try {
        const post = await Post.findById(id);
        console.log('>>> getPost: Found post by the given id...');
        const user = await User.findById(post.creatorId)
        console.log('>>> getPost: Found post creator data');
        response.status(200).json({ ...post._doc, name: user.name, surname: user.surname });
        console.log('>>> getPost: Sent post with name and surname of creator to client');
    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}
*/

export const getFavorConstants = async (request, response) => {

    try {
        console.log(JSON.stringify({ USER_TYPES, FAVOR_CATEGORIES, LOCATIONS }))
        response.status(200).json(JSON.stringify({ USER_TYPES, FAVOR_CATEGORIES, LOCATIONS }));
        console.log('>>> getFavorConstants: Returned constants useful for creating a favor post!');
    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}


export const getPostsBySearch = async (request, response) => {
    const { searchQuery, userTypeToSearch } = request.query;
    console.log(">>> getPostsBySearch: Search query is " + searchQuery);
    try {
        // the flag 'i' ignores the case of the string.
        const searchQuery_RegExp = new RegExp(searchQuery, 'i');
        console.log(">>> getPostsByCategory: RegExp of searchquery is " + searchQuery_RegExp)
        const userTypeToSearch_RegExp = new RegExp(userTypeToSearch, 'i');
        console.log(">>> getPostsByCategory: RegExp of userTypeToSearch is " + userTypeToSearch_RegExp)

        // Find all the posts that matches the taskCategory or location of posted by the userType provided.
        const posts = await Post.find({$and:[{userType: userTypeToSearch_RegExp},{toHide: false},{$or:[{taskCategory: searchQuery_RegExp},{location: searchQuery_RegExp}]}]});
        console.log(">>> getPostsBySearch: Number of posts found through search: " + posts.length);
        if (posts.length > 0) {
            console.log(">>> getPostsBySearch: Updating searched posts with users data...");
            var postsWithSideInfo = []
            for (const document of posts) {
                var user = await User.findById(document.creatorId);
                if (user) {
                    var newDocument = await createJsonPost(document, user, document.userType)
                    postsWithSideInfo = [...postsWithSideInfo, newDocument]
                }
            }
            console.log(">>> getPostsBySearch: Sent "+postsWithSideInfo.length+" posts enriched with side information.");
            return response.status(200).json({ data: postsWithSideInfo });
        }
        else
            return response.status(200).json({ data: posts });
    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}


export const bookFavor = async (request, response) => {
    const { id } = request.params;
    console.log(">>> bookFavor: Trying to book Favor with id: " + id);
    try {

        if (!request.userId)
            return response.status(401).json({ message: 'Unauthenticated' });

        if (!mongoose.Types.ObjectId.isValid(id))
            return response.status(400).send(`No post with id: ${id}`);

        const postToBook = await Post.findById(id);

        if (postToBook.toHide == true)
            return response.status(400).json({ message: 'Favor already booked!' });

        if (request.userId == postToBook.creatorId){
            console.log('>>> bookFavor: Cannot book your own favor. Returning status 400!')
            return response.status(400).json({ message: 'Cannot book your own favor!' });
        }

        var providerId = '';
        var callerId = '';
        console.log(postToBook.userType)
        if (postToBook._doc.userType == PROVIDER) {
            providerId = postToBook.creatorId;
            callerId = request.userId;
        }
        else if (postToBook._doc.userType == CALLER) {
            providerId = request.userId;
            callerId = postToBook.creatorId;
        }
        else
            return response.status(400).json({ message: "Error on userType in the post to book!" });

        const newBookedFavor = new BookedFavor({ bookedAt: new Date().toISOString(), providerId: providerId, callerId: callerId, post: postToBook._doc, isCompleted: false });
        await newBookedFavor.save();
        console.log("This is the new booked favor: ", newBookedFavor);

        //await Post.findByIdAndRemove(id);
        postToBook.toHide = true;
        await Post.findByIdAndUpdate(id, postToBook, { new: true });

        return response.status(200).json({ message: 'Favor booked successfully.' });

    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}


export const getFavorCategories = async (request, response) => {
    try {
        console.log(JSON.stringify(FAVOR_CATEGORIES));
        response.status(200).json(JSON.stringify(FAVOR_CATEGORIES));
        console.log('>>> getFavorCategories: Returned categories useful for feed carousel!');
    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}