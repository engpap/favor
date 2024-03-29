import mongoose from 'mongoose';

import { noProfilePicture64String } from '../assets/base64stringImages.js'

import { GENDERS, CITIES, JOBS } from '../constants/personalInfo.js';

const userSchema = mongoose.Schema({
    id: { type: String }, //created by db
    externalId: { //foreign key to keep track of external service signups
        type: String,
        default: null,
    },
    externalSignInService: { type: String, default: null },

    name: { type: String, required: true },
    surname: { type: String }, //TODO: make required (proper algorithm with google)
    email: { type: String, required: true },
    password: { type: String },

    
    profilePicture: { type: String, default: noProfilePicture64String },
    
    gender: { type: String, enum: GENDERS },
    age: { type: Number },
    city: { type: String, enum: CITIES },
    job: { type: String, enum: JOBS },
    
    bio: { type: String, default: "Hi, I am available to do favors!" },
    
    averageRatings: {
        type: Number,
        float: true,
        default: 0.0,
        min: 0,
        max: 5
    },

});

const User = mongoose.model('User', userSchema);

export default User;