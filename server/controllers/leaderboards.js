import Leaderboard from "../models/leaderboard.js";

export const getLeaderboard = async (request, response) => {
    var { userType, location } = request.query;
    try {
        // the flag 'i' ignores the case of the string.
        userType = userType.toLowerCase();
        location = location.toUpperCase();
        console.log(">>> getLeaderboard: Search query is ", userType,location);

        const filter = { userType: userType, location: location }
        // Find the leaderboard that matches the userType and location.
        const leaderboard = await Leaderboard.findOne(filter);
        console.log(">>> getLeaderboard: Leaderboard found: " + leaderboard);
        response.json({ data: leaderboard });
    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}