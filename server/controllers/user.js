import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

import User from '../model/user.js';

export const signup = async (req, res) => {
    const { email, password, confirmPassword, firstName, lastName } = req.body;
    try {
        const existingUser = await User.findOne({ email });

        if (existingUser)
            return res.status(400).json({ message: "User already signed up" });

        if (password !== confirmPassword)
            return res.status(400).json({ message: "Confirm password is different from provided password" })

        // Hash the password with a salt level of 12
        const hashedPassword = await bcrypt.hash(password, 12);

        const newUser = await User.create({ email, password: hashedPassword, name: `${firstName} ${lastName}` });
        response.status(201).json(newUser);

    } catch (error) {
        response.status(500).json({ message: "Something went wrong." });
    }
}
