import express from 'express';
import { createPost } from '../controllers/posts.js';
import auth from '../middleware/auth.js'

const router = express.Router();

router.post('/', auth, createPost);

export default router;