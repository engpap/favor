import express from 'express';
import { getStatistics } from '../controllers/admin.js'
import auth from '../middleware/auth.js'

const router = express.Router();

router.get('/getStatistics', auth,  getStatistics);

export default router;