import express from 'express';
import { signup, signin, continueWithExternalService, insertPersonalInfo, getProfileConstants} from '../controllers/user.js'
import auth from '../middleware/auth.js'

const router = express.Router();

router.post('/continue', continueWithExternalService);
router.post('/signup', signup);
router.post('/signin', signin);
router.post('/insertPersonalInfo', auth, insertPersonalInfo);

router.get('/getProfileConstants', getProfileConstants);

export default router;