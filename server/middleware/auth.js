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
        console.log("current token:",token)

        if (!token)
            return response.status(401).json({ message: "No auth token, access denied" });

        const verified = jwt.verify(token, process.env.GOOGLE_CLIENT_SECRET);
        if (!verified)
            return response.status(401).json({ message: "Token verification failed, authorization denied." });

        request.userId = verified.id;
        console.log(">>> User authenticated!");
        console.log(">>> user id: ",request.userId);

        /*
        const isCustomAuth = token?.length < 500;

        let decodedData;

    
        // CUSTOM AUTH
        if (token && isCustomAuth) { 
            decodedData = jwt.verify(token, process.env.GOOGLE_CLIENT_SECRET);
            // Adding a property to request
            request.userId = decodedData?.id;
            console.log("Authenticating user...")
        }
        // GOOGLE AUTH
        else { 
            decodedData = jwt.decode(token);    
            // Adding a property to request
            request.userId = decodedData?.sub;
            console.log("Authenticating Google user...")
        }
        */
        next();
    } catch (error) {
        console.log(error);
        return response.status(400).json({ message: "Authorization failed!" });
    }
}

export default auth;