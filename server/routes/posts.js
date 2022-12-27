import express from 'express';
import { createPost, getPosts, getPostsBySearch,getFavorConstants} from '../controllers/posts.js';
import auth from '../middleware/auth.js'

const router = express.Router();

router.get('/search', getPostsBySearch);
router.get('/', getPosts);
router.get('/getFavorConstants', getFavorConstants);
//router.get('/:id', getPost);

router.post('/create', auth, createPost);

export default router;