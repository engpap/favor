import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import dotenv from "dotenv"; // to read .env file
import { OAuth2Client } from 'google-auth-library';

import User from '../models/user.js';
import { EMAIL_ERROR, PASSWORD_ERROR, SERVER_ERROR } from '../constants/errorTypes.js';
import { GENDERS,CITIES,JOBS } from '../constants/personalInfo.js';

dotenv.config();

export const signup = async (req, res) => {
    console.log(">>> SignUp: Signing up");
    const { name, surname, email, password, confirmPassword } = req.body;
    try {
        if (!email.toLowerCase().match(/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/))
            return res.status(400).json({ message: "Wrong format of email address", errorType: EMAIL_ERROR });

        const existingUser = await User.findOne({ email });

        if (existingUser)
            return res.status(400).json({ message: "User already signed up", errorType: EMAIL_ERROR });

        if (password !== confirmPassword)
            return res.status(400).json({ message: "Confirm password is different from provided password", errorType: PASSWORD_ERROR })
       
        // Hash the password with a salt level of 12
        const hashedPassword = await bcrypt.hash(password, 12);
        
        const newUser = await User.create({ email, password: hashedPassword, name: name, surname: surname });
        console.log("cia")
        const token = jwt.sign({ email: newUser.email, id: newUser._id }, process.env.GOOGLE_CLIENT_SECRET, { expiresIn: "1h" });
        console.log(">>> SignUp: Sending response to user");
        res.status(201).json({ newUser, token });

    } catch (error) {
        res.status(500).json({ message: "Something went wrong.", errorType: SERVER_ERROR });
    }
}


export const signin = async (req, res) => {
    console.log(">>> SignIn: Signing in");
    const { email, password } = req.body;

    try {

        if (!email.toLowerCase().match(/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/))
            return res.status(400).json({ message: "Wrong format of email address", errorType: EMAIL_ERROR });

        const existingUser = await User.findOne({ email: email });

        if (!existingUser)
            return res.status(404).json({ message: "User does not exists", errorType: EMAIL_ERROR });

        const isPasswordCorrect = await bcrypt.compare(password, existingUser.password);

        if (!isPasswordCorrect)
            return res.status(400).json({ message: "Wrong password", errorType: PASSWORD_ERROR });

        const token = jwt.sign({ email: existingUser.email, id: existingUser._id }, process.env.GOOGLE_CLIENT_SECRET, { expiresIn: "1h" });

        //The _doc field lets you access the "raw" document directly, 
        // which was delivered through the mongodb driver, bypassing mongoose.
        console.log(">>> SignIn: Sending response to user");
        console.log("Following user logged in successfully: ",existingUser._doc);
        res.status(200).json({ token, ...existingUser._doc });

    } catch (error) {
        return res.status(500).json({ message: "Something went wrong", errorType: SERVER_ERROR });
    }

}


// Notice that two users with different emails but same externalId can register without problems. TODO: Make emial work as unique.
// https://developers.google.com/identity/sign-in/android/backend-auth#calling-the-tokeninfo-endpoint

export const continueWithExternalService = async (req, res) => {
    console.log("ContinueWithGoogle: Continuing with Google")
    const { name, surname, email, tokenId } = req.body; // If user has already signed up with the external service, only email and externalId are required.
    try {
        const userIdFromGoogle = await verifyGoogleIdToken(tokenId);
        const existingUser = await User.findOne({ email });
        if (existingUser) { // sign in
            if (existingUser.externalId && existingUser.externalId == userIdFromGoogle) { // User is a google user
                console.log("ContinueWithGoogle: Signing user in with Google service")
                const token = jwt.sign({ email: existingUser.email, id: existingUser._id }, process.env.GOOGLE_CLIENT_SECRET, { expiresIn: "1h" });
                res.status(200).json({ token, ...existingUser._doc });
            }
            else { // User is not a google user since have externalId null
                console.log("ContinueWithGoogle: User has already signed up with email")
                return res.status(400).json({ message: "User already signed up with email", errorType: EMAIL_ERROR });
            }
        }
        else { // sign up
            console.log("ContinueWithGoogle: Signing user up with Google")
            const newUser = await User.create({ email, name: name, surname: surname, externalId: userIdFromGoogle, externalSignInService: 'Google' });
            const token = jwt.sign({ email: newUser.email, id: newUser._id }, process.env.GOOGLE_CLIENT_SECRET, { expiresIn: "1h" });
            res.status(201).json({ token, ...newUser._doc });
        }

    } catch (error) {
        console.log("ContinueWithGoogle: Exception has occurred -> " + error)
        res.status(500).json({ message: "Something went wrong.", errorType: SERVER_ERROR });
    }

}


const verifyGoogleIdToken = async (tokenId) => {
    console.log("ContinueWithGoogle: Verifying Google Id Token")
    const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);
    const ticket = await client.verifyIdToken({ idToken: tokenId, audience: process.env.GOOGLE_CLIENT_ID });  // Specify the CLIENT_ID of the app that accesses the backend or, if multiple clients access the backend: [CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3]
    const payload = ticket.getPayload();
    const userIdFromGoogle = payload['sub'];
    return userIdFromGoogle;
}


export const insertPersonalInfo = async (request, response) => {

    console.log(">>> InsertPersonalInfo: Inserting personal information...");
    const { proilePicture, gender, age, job, city, bio} = request.body;
    try {
        if(parseInt(age)<=0)
            return response.status(400).json({ message: "Wrong age"});

        const existingUser = await User.findById(request.userId);

        if (!existingUser)
            return response.status(400).json({ message: "User has not registered yet"});
        
        if(!(proilePicture && gender && age && job && city && bio))
            return response.status(400).json({ message: "Some data is missing. Please, fill all the fields."});

        const updatedUser = {...existingUser._doc, profilePicture: proilePicture, gender: gender, age: age, job: job, city: city, bio: bio };

        await User.findByIdAndUpdate(request.userId, updatedUser, { new: true });
        
        console.log(">>> InsertPersonalInfo: User profile correctly updated with personal info!");

        return response.status(200).json({ message: "User profile correctly updated with personal info!" });

    } catch (error) {
        response.status(500).json({ message: "Something went wrong.", errorType: SERVER_ERROR });
    }
}

export const getProfileConstants = async (request, response) => {
    try {
        console.log(JSON.stringify({ GENDERS,  CITIES, JOBS }))
        response.status(200).json(JSON.stringify({ GENDERS, CITIES,JOBS }));
        console.log('>>> getProfileConstants: Returned constants useful for updating a user profile!');
    } catch (error) {
        response.status(404).json({ message: error.message });
    }
}