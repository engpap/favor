import mongoose from 'mongoose';

import { USER_TYPES } from '../constants/userTypes.js';
import { FAVOR_CATEGORIES } from '../constants/favorCategories.js'
import { LOCATIONS } from '../constants/locations.js'

/*
    For creating the post, from client body POST request is required:
    - userType
    - taskCategory
    - location
    - taskStartTime (if userType is CALLER)
    - availabilityStartTime (if userType is PROVIDER)
    - availabilityEndTime (if userType is PROVIDER)
    - description
*/
const postSchema = mongoose.Schema({
    creatorId: { type: String, required: true }, //not in body
    createdAt: { //not in body; generated from server as a ISO format string
        type: Date,
        default: new Date(),
    },
    // name and surname are queired when needed on creatorId
    userType: { type: String, enum: USER_TYPES, required: true }, //caller or provider
    taskCategory: { type: String, enum: FAVOR_CATEGORIES, required: true }, //category of the activity
    location:  { type: String, enum: LOCATIONS, required: true },
    
    //Dates are passed thought the internet as a ISO format string
    taskStartTime: Date, // it is null for provider's posts
    availabilityStartTime: Date, // it is null for caller's posts
    availabilityEndTime: Date, // it is null for caller's posts

    description: { type: String, required: true },
});

const Post = mongoose.model('Post', postSchema);

export default Post;