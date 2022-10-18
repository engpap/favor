import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import dotenv from "dotenv"; // to read .env file

import User from '../model/user.js';

dotenv.config();

export const signup = async (req, res) => {
    const { firstName, lastName, email, password, confirmPassword } = req.body;
    try {
        if (!email.toLowerCase().match(/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/))
            return res.status(400).json({ message: "Wrong format of email address", errorType: "email" });

        const existingUser = await User.findOne({ email });

        if (existingUser)
            return res.status(400).json({ message: "User already signed up", errorType: "email" });

        if (password !== confirmPassword)
            return res.status(400).json({ message: "Confirm password is different from provided password", errorType: "password" })

        // Hash the password with a salt level of 12
        const hashedPassword = await bcrypt.hash(password, 12);

        const newUser = await User.create({ email, password: hashedPassword, firstName: firstName, lastName: lastName });
        res.status(201).json(newUser);

    } catch (error) {
        res.status(500).json({ message: "Something went wrong." });
    }
}


export const signin = async (req, res) => {
    const { email, password } = req.body;

    try {

        if (!email.toLowerCase().match(/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/))
            return res.status(400).json({ message: "Wrong format of email address", error: "email" });

        const existingUser = await User.findOne({ email: email });

        if (!existingUser)
            return res.status(404).json({ message: "User does not exists", errorType: "email" });

        const isPasswordCorrect = await bcrypt.compare(password, existingUser.password);

        if (!isPasswordCorrect)
            return res.status(400).json({ message: "Wrong password", error: "password" });

        const token = jwt.sign({ id: existingUser._id }, process.env.KEY, { expiresIn: "7d" });

        //The _doc field lets you access the "raw" document directly, 
        // which was delivered through the mongodb driver, bypassing mongoose.
        res.status(200).json({ token, ...existingUser._doc });

    } catch (error) {
        return res.status(500).json({ message: "Something went wrong" });
    }

}