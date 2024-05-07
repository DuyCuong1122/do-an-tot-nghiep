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

router.post("/",(req, res) => res.send('Hello World')) 

// Route for user signin
router.post("/signin", controller.signin);

module.exports = router;
