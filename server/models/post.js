import mongoose from 'mongoose';

import { PROVIDER, CALLER, ADMIN } from '../constants/userTypes.js';
import { DOG_SITTING, HOME_REPAIR, HOME_CLEANING, OUTDOOR_CLEANING } from '../constants/taskCategories.js';

const userTypes = [PROVIDER, CALLER, ADMIN];
const taskCategories = [DOG_SITTING,HOME_REPAIR,HOME_CLEANING,OUTDOOR_CLEANING];

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
    userType: { type: String, enum: userTypes, required: true }, //caller or provider
    taskCategory: { type: String, enum: taskCategories, required: true }, //category of the activity
    location:  String,
    /*location: {
        address: { type: String, required: true },
        city: { type: String, required: true },
        postalCode: { type: String, required: true },
        country: { type: String, required: true },
    },*/

    //Dates are passed thought the internet as a ISO format string
    taskStartTime: Date, // it is null for provider's posts
    availabilityStartTime: Date, // it is null for caller's posts
    availabilityEndTime: Date, // it is null for caller's posts

    description: { type: String, required: true },
});

const Post = mongoose.model('Post', postSchema);

export default Post;