const express = require("express")

const router = express.Router()
const commentController = require("../controllers/comment.controller")

router.get("/comments", commentController.getAllComments)
router.get("/comment/:idPost", commentController.getCommentByPostId)
router.post("/comment", commentController.addComment)
router.put("/comment/:id", commentController.updateComment)
router.delete("/comment/:id", commentController.deleteComment)

module.exports = router