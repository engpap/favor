import express from 'express';
import { getBookedFavors, completeFavor} from '../controllers/favors.js';
import auth from '../middleware/auth.js'

const router = express.Router();


router.get('/getBookedFavors', getBookedFavors);


router.post('/complete', auth, completeFavor);


export default router;