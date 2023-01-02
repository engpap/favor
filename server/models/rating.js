import mongoose from 'mongoose';

const postSchema = mongoose.Schema({
    rating: {
        type: Number,
        required: true,
        min: 1,
        max: 5
      },
      user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
      },
      favor: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'BookedFavor',
        required: true
      }
});

const Rating = mongoose.model('Rating', postSchema);

export default Rating;