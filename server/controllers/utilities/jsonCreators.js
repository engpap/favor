import { getLeaderboardPosition } from "./runtimeGetters.js"

export const createJsonPost = async (post, user, userType) => {
    return {
        ...post._doc,
        name: user.name,
        surname: user.surname,
        profilePicture: user.profilePicture,
        bio: user.bio,
        averageRatings: user.averageRatings ? user.averageRatings : 0,
        rankingPosition: await getLeaderboardPosition(user._id, userType, post._doc.location),
        rankingLocation: post._doc.location
    }
}

