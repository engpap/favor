import BookedFavor from "../models/bookedFavor.js";


export const getStatistics = async (request, response) => {
    console.log(">>> getStatistics: Getting statistics as admin...");
    try {
        BookedFavor.aggregate([
            {
                $lookup: {
                    from: 'posts',
                    localField: 'post',
                    foreignField: '_id',
                    as: 'post'
                }
            },
            {
                $unwind: '$post'
            },
            {
                $group: {
                    _id: '$post.location',
                    //count: { $sum: 1 }, To return the completed and non_completed
                    completedCount: {
                        $sum: {
                            $cond: [
                                { $eq: ['$isCompleted', true] },
                                1,
                                0
                            ]
                        }
                    }
                }
            }
        ], function (error, results) {
            if (error) {
                console.error(">>> Occured an error:", error);
                return response.status(404).json({ message: error.message });
            } else {
                console.log(results);
                return response.status(200).json(results);
            }
        });

    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}


