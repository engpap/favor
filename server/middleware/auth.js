import jwt from 'jsonwebtoken';

/**
 * For example, if the user wants to like a post.
 * They click the like button; the middleware checks if the user has permission to like it.
 * If there are permissions, the next() function is called.
 * 
 * If the length of the token is less than 500, it is not a Google Auth token. 
 */
const auth = async (request, response, next) => {
    try {
        const token = request.header("x-auth-token");
        console.log(">>> auth: current token is", token);

        if (!token)
            return response.status(401).json({ message: "No auth token, access denied" });

        try {
            const verified = jwt.verify(token, process.env.GOOGLE_CLIENT_SECRET);
            if (!verified)
                return response.status(401).json({ message: "Token verification failed, authorization denied." });
            request.userId = verified.id;
            console.log(">>> auth: User authenticated!");
            console.log(">>> auth: userId is ", request.userId);
        } catch (e) {
            return response.status(401).json({ message: "Token expired. Please, sign in again." });
        }
        next();
    } catch (error) {
        console.log(error);
        return response.status(400).json({ message: "Authorization failed!" });
    }
}

export default auth;