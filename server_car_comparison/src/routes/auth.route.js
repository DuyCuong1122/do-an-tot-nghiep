const express = require('express');
const router = express.Router();
const { verifySignUp } = require("../middleware");
const controller = require("../controllers/auth.controller");


// Route for user signup
router.post(
    "/signup",
    [
        verifySignUp.checkDuplicateUsernameOrEmail,
        verifySignUp.checkRolesExisted
    ],
    controller.signup
);

// Route for user signin
router.post("/signinGmail", controller.signinWithGoogle);
router.post("/signin", controller.signin);

module.exports = router;
