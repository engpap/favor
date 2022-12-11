import mongoose from 'mongoose';
import PostMessage from '../models/post.js';
import { PROVIDER, CALLER, ADMIN } from '../constants/userTypes.js';

export const createPost = async (request, response) => {
    const { userType,taskStartTime, availabilityStartTime,availabilityEndTime } = request.body;
    
    if(userType==PROVIDER){
        if(taskStartTime)
            response.status(400).json({ message: "Provider cannot have taskStartTime value" });
    }
    else if(userType==CALLER){
        if(availabilityStartTime || availabilityEndTime)
            response.status(400).json({ message: "Caller cannot have availabilityStartTime and availabilityEndTime values" });
    }
    else{
        response.status(400).json({ message: "Post creator should be a CALLER or a PROVIDER" });
    }
    
    console.log('>>> createPost: Creating post...'); 
    const newPost = new PostMessage({ ...request.body, creatorId: request.userId, createdAt: new Date().toISOString() });

    try {
        await newPost.save();
        console.log('>>> createPost: Post created!'); 
        response.status(201).json(newPost);
    } catch (error) {
        response.status(409).json({ message: error.message });
    }
}
