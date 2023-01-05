import Leaderboard from "../../models/leaderboard.js";

export const getLeaderboardPosition = async (userId, userType, location) => {

    const filter = { userType: userType, location: location, 'users.user': userId }
    const leaderboard = await Leaderboard.findOne(filter);

    if (leaderboard) {
        const { users } = leaderboard;
        const userPostionInLeaderboard = users.findIndex((element) => element.user._id.equals(userId));
        return userPostionInLeaderboard + 1; //Otherwise first position would be 0!
    }
    else
        return 0;
}