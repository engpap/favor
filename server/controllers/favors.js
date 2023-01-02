import BookedFavor from "../models/bookedFavor.js";
/**
 * 
 * @param {*} request contaning the query parameter about the page
 * @param {*} response contaning a maximum number of posts equals to LIMIT value, the current page, the total number of pages
 */
export const getBookedFavors = async (request, response) => {
    const { page } = request.query;
    try {
        const LIMIT = 4;
        const pageStartIndex = (Number(page) - 1) * LIMIT;

        const total = await BookedFavor.countDocuments({});

        // To return all documents in a collection, omit parameter of find().  
        // To sort posts from newest to oldest order, pass -1 as the parameter of sort().
        // To skip the posts before the current page start index.
        const bookedFavors = await BookedFavor.find().sort({ _id: -1 }).limit(LIMIT).skip(pageStartIndex);

        var newBookedFavors = []
        for (const document of bookedFavors) {
            if (!document.isTerminated) {
                console.log(document.post.toHexString())
                var post = await Post.findById(document.post.toHexString());
                var user = await User.findById(post._doc.creatorId);
                var jsonPost = { ...post._doc, name: user.name, surname: user.surname, profilePicture: user.profilePicture, bio: user.bio, averageStars: user.averageStars, rankingPosition: 1, rankingLocation: 'to_define' }
                var newDocument = { ...document._doc, post: { ...jsonPost } }
                newBookedFavors = [...newBookedFavors, newDocument]
            }
        }

        response.status(200).json({ data: newBookedFavors, currentPage: Number(page), numberOfPages: Math.ceil(total / LIMIT) });
        console.log(">>> getBookedFavors: Sent bookedFavors to client");
    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}


export const completeFavor = async (request, response) => {
    const { bookedFavorId } = request.body;
    try {
        const bookedFavor = await BookedFavor.findById(bookedFavorId);
        
        console.log(">>> completeFavor: Marking the booked favor as terminated")

        if (bookedFavor.providerId != request.userId)
            return response.status(400).json({ message: "Cannot mark a favor as completed if you are not the provider" });

        bookedFavor.isTerminated = true;

        await BookedFavor.findByIdAndUpdate(bookedFavorId, bookedFavor, { new: true });
        console.log(">>> completeFavor: Marked the booked favor as terminated")
        return response.status(200).json({ message: bookedFavorId + " marked as completed" });

    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}