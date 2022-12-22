import mongoose from 'mongoose';
import Post from '../models/post.js';
import User from '../models/user.js';
import axios from 'axios';
import FormData from 'form-data';

import { PROVIDER, CALLER, ADMIN, USER_TYPES } from '../constants/userTypes.js';
import { FAVOR_CATEGORIES } from '../constants/favorCategories.js'
import { LOCATIONS } from '../constants/locations.js'

export const createPost = async (req, res) => {
    const { userType, favorStartTime, availabilityStartTime, availabilityEndTime, description } = req.body;
    console.log(userType, favorStartTime,availabilityStartTime, availabilityStartTime)

    // Check if post fields respects the user type
    if (userType == PROVIDER) {
        if (favorStartTime){
            console.log("Provider is trying to create a post but 'favorStartTime' is not null!")
            return res.status(400).json({ message: "Provider cannot have favorStartTime value" });
        }
    }
    else if (userType == CALLER) {
        if (availabilityStartTime || availabilityEndTime){
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
    console.log(newPost)
    try {
        await newPost.save();
        console.log('>>> createPost: Post created!');
        res.status(201).json(newPost);
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
    const { page } = request.query;
    try {
        const LIMIT = 4;
        const pageStartIndex = (Number(page) - 1) * LIMIT;

        const total = await Post.countDocuments({});

        // To return all documents in a collection, omit parameter of find().  
        // To sort posts from newest to oldest order, pass -1 as the parameter of sort().
        // To skip the posts before the current page start index.
        const posts = await Post.find().sort({ _id: -1 }).limit(LIMIT).skip(pageStartIndex);

        console.log(">>> getPosts: Updating posts with users data...");
        var newPosts = []
        for (const document of posts) {
            var user = await User.findById(document.creatorId);
            var newDocument = { ...document._doc, name: user.name, surname: user.surname}
            console.log(newDocument);
            newPosts = [...newPosts, newDocument]
        }

    response.status(200).json({ data: newPosts, currentPage: Number(page), numberOfPages: Math.ceil(total / LIMIT) });
    console.log(">>> getPosts: Sent posts to client");
} catch (error) {
    response.status(404).json({ message: error.message });
}
}


/**
 * 
 * @param {*} request containing as parameter the id of the post the client wants to retrieve
 * @param {*} response containing the requested post
 */
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


export const getFavorConstants = async (request, response) => {

    try {
        console.log("inside")
        console.log(JSON.stringify({USER_TYPES,FAVOR_CATEGORIES,LOCATIONS}))
        response.status(200).json(JSON.stringify({USER_TYPES,FAVOR_CATEGORIES,LOCATIONS}));
        console.log('>>> getFavorConstants: Returned constants useful for creating a favor post!');
    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}

