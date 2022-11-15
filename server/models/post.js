import mongoose from 'mongoose';

const postSchema = mongoose.Schema({
    creatorId: String, //not in body
    createdAt: { //generated from server as a ISO format string
        type: Date,
        default: new Date(),
    },
    name: String,
    surname: String,
    userType: String, //caller or provider
    taskTitle: String,
    taskCategory: String, //category of the activity
    taskSubcategory: String, //subcategory of the activity
    location: {
        address: String,
        city: String,
        postalCode: String,
        country: String,
    },
    time: { //it is passed thought the internet as a ISO format string
        type: Date,
        default: new Date(),
    },
    description: String,
});

const Post = mongoose.model('Post', postSchema);

export default Post;