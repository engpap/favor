import { getLeaderboardPosition } from "./runtimeGetters.js"

export const createJsonPost = async (post,user) =>{
    return { ...post._doc,
         name: user.name, 
         surname: user.surname, 
         profilePicture: user.profilePicture, 
         bio: user.bio, 
         averageStars: user.averageStars, 
         rankingPosition: await getLeaderboardPosition(user._id, post._doc.userType, post._doc.location),
         rankingLocation: post._doc.location }
}

