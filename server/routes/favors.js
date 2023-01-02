import express from 'express';
import { getBookedFavors, completeFavor, rateFavor} from '../controllers/favors.js';
import auth from '../middleware/auth.js'

const router = express.Router();


router.get('/getBookedFavors', getBookedFavors);


router.post('/:id/rateFavor', auth, rateFavor) //TODO: make it return something
router.post('/:id/completeFavor', auth, completeFavor); //TODO: make it patch, make it return something


export default router;