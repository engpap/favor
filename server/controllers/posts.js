import mongoose from 'mongoose';
import PostMessage from '../models/post.js';

export const createPost = async (request, response) => {
    const newPost = new PostMessage({ ...request.body, creatorId: request.userId, createdAt: new Date().toISOString() });

    try {
        await newPost.save();
        response.status(201).json(newPost);
    } catch (error) {
        response.status(409).json({ message: error.message });
    }
}
