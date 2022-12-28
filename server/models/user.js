import mongoose from 'mongoose';
import  fs from 'fs'; 
import { noProfilePicture64String } from '../assets/base64stringImages.js'

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

    rankingPoints: { type: Number, default: 0 },
    averageStars: { type: Number, default: 0.1 },

});

const User = mongoose.model('User', userSchema);

export default User;