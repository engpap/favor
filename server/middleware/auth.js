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
     
        const token = request.headers.authorization?.split(" ")[1];
        const isCustomAuth = token?.length < 500;

        let decodedData;

        // CUSTOM AUTH
        if (token && isCustomAuth) { 
            decodedData = jwt.verify(token, process.env.GOOGLE_CLIENT_SECRET);
            // Adding a property to request
            request.userId = decodedData?.id;
        }
        // GOOGLE AUTH
        else { 
            decodedData = jwt.decode(token);    
            // Adding a property to request
            request.userId = decodedData?.sub;
        }
        next();
    } catch (error) {
        console.log(error);
    }
}

export default auth;