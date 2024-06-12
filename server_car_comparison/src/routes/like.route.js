const express = require("express")

const router = express.Router()
const likeController = require("../controllers/like.controller")

router.get("/likes", likeController.getAllLikes)
router.get("/like/:idPost", likeController.getLikeByPostId)
router.post("/like", likeController.LikeOrNot)
router.put("/like/:id", likeController.updateLike)
router.post("/checkLike", likeController.checkLike)

module.exports = router