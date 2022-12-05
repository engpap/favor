import express from 'express';
import { signup, signin, continueWithExternalService } from '../controllers/user.js'

const router = express.Router();

router.post('/continue', continueWithExternalService);
router.post('/signup', signup);
router.post('/signin', signin);

export default router;