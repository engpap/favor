import express from "express";
import bodyParser from "body-parser";
import mongoose from "mongoose";
import cors from "cors";
import dotenv from "dotenv"; // to read .env file

import userRoutes from './routes/user.js';
import postRoutes from './routes/posts.js';
import favorRoutes from './routes/favors.js';
import leaderboardRoutes from './routes/leaderboards.js';

const app = express();
dotenv.config();

// Set up of bodyParser to send requests
app.use(bodyParser.json({ limit: "30mb", extended: true }));
app.use(bodyParser.urlencoded({ limit: "30mb", extended: true }));
app.use(cors());

app.use('/leaderboards', leaderboardRoutes);
app.use('/favors', favorRoutes);
app.use('/posts', postRoutes);
app.use('/user', userRoutes);

const PORT = process.env.PORT;

mongoose.connect(process.env.CONNECTION_URL, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => app.listen(PORT, () => console.log(`Server Running on Port: http://localhost:${PORT}`)))
    .catch((error) => console.log(`${error} did not connect`));