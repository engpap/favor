import express from 'express';
import { getLeaderboard } from '../controllers/leaderboards.js';

const router = express.Router();

router.get('/', getLeaderboard);

export default router;