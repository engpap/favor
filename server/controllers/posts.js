import mongoose from 'mongoose';
import PostMessage from '../models/post.js';
import axios from 'axios';
import FormData from 'form-data';

import { PROVIDER, CALLER, ADMIN } from '../constants/userTypes.js';


export const createPost = async (request, res) => {
    const { userType, taskStartTime, availabilityStartTime, availabilityEndTime, description } = request.body;

    // Check if post fields respects the user type
    if (userType == PROVIDER) {
        if (taskStartTime)
            res.status(400).json({ message: "Provider cannot have taskStartTime value" });
    }
    else if (userType == CALLER) {
        if (availabilityStartTime || availabilityEndTime)
            res.status(400).json({ message: "Caller cannot have availabilityStartTime and availabilityEndTime values" });
    }
    else {
        res.status(400).json({ message: "Post creator should be a CALLER or a PROVIDER" });
    }

    // Use Sightengine API to moderate description text
    const data = new FormData();
    data.append('text', description);
    data.append('lang', 'en');
    data.append('opt_countries', 'us,gb,fr');
    data.append('mode', 'standard');
    data.append('api_user', '194920429');
    data.append('api_secret', process.env.SIGHTENGINE_SECRET_API);


    try{
        console.log('>>> createPost: Sending request to Sightengine...');
        const apiResponse = await axios({
            url: 'https://api.sightengine.com/1.0/text/check.json',
            method: 'post',
            data: data,
            headers: data.getHeaders()
        })
        if(apiResponse?.data?.profanity?.matches.length){ //if profanity.matches array has a length grater than 0, then some inappropriate data has been found
            console.log("Sightengine API response", apiResponse?.data);
            return res.status(409).json({ message: error.message });
        }
        else{
            console.log('>>> createPost: Description does not contain inappropriate data');
        }
            
    }catch(error){
        return res.status(400).json({ message: "Post description contains inappropriate data" });
    }

    console.log('>>> createPost: Creating post...');
    const newPost = new PostMessage({ ...request.body, creatorId: request.userId, createdAt: new Date().toISOString() });

    try {
        await newPost.save();
        console.log('>>> createPost: Post created!');
        res.status(201).json(newPost);
    } catch (error) {
        res.status(409).json({ message: error.message });
    }
}
