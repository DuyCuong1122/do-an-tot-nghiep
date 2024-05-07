const express = require('express');
const router = express.Router();
const { authJwt } = require("../middleware");
const controller = require("../controllers/user.controller");

// Middleware for setting CORS headers
router.use(function(req, res, next) {
    res.header(
        "Access-Control-Allow-Headers",
        "x-access-token, Origin, Content-Type, Accept"
    );
    next();
}); 

// Public route accessible to all
router.get("/test/all", controller.allAccess);

// Protected routes with authentication middleware
router.get("/test/user", [authJwt.verifyToken], controller.userBoard);

router.get(
    "/test/mod",
    [authJwt.verifyToken, authJwt.isModerator],
    controller.moderatorBoard
);

router.get(
    "/test/admin",
    [authJwt.verifyToken, authJwt.isAdmin],
    controller.adminBoard
);

module.exports = router;
