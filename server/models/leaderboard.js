import mongoose from 'mongoose';
import { LOCATIONS } from '../constants/locations.js';
import { USER_TYPES } from '../constants/userTypes.js';

const { Schema } = mongoose;

/**
 * For simplicity, score is the sum of each new average rating
 */
const leaderboardSchema = new Schema({
    location: {
        type: String,
        enum: LOCATIONS,
        required: true,
    },
    userType: {
        type: String,
        enum: USER_TYPES,
        required: true,
    },
    users: [
        {
            user: {
                type: mongoose.Schema.Types.ObjectId,
                ref: 'User',
                required: true
            },
            score: {
                type: Number,
                required: true,
            },
        },
    ],
});

const Leaderboard = mongoose.model('Leaderboard', leaderboardSchema);

export default Leaderboard;




