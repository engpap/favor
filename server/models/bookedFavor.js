import mongoose from 'mongoose';

const { Schema } = mongoose;

const bookedFavorSchema = mongoose.Schema({
    bookedAt: { //not in body; generated from server as a ISO format string
        type: Date,
        default: new Date(),
    },
    providerId: { type: String, required: true },
    callerId:  { type: String, required: true },
    post: { type: Schema.Types.ObjectId, ref: 'Post' },
    isTerminated: { type: Boolean, default:false, required: true},
});

const BookedFavor = mongoose.model('BookedFavor', bookedFavorSchema);

export default BookedFavor;