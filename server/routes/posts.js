import express from 'express';
import { createPost, getPosts, getPost} from '../controllers/posts.js';
import auth from '../middleware/auth.js'

const router = express.Router();

router.get('/', getPosts);
router.get('/:id', getPost);

router.post('/create', auth, createPost);

export default router;