const express = require("express")
const router = express.Router()
const postController = require("../controllers/post.controller")
router.get("/posts", postController.getAllPosts)
router.get("/post/detail/:id", postController.getDetailPost)
router.get("/post/:title", postController.getPostByTitle)

router.post("/post", postController.addPost)
router.put("/post/:id", postController.updatePost)
router.delete("/post/:id", postController.deletePost)

module.exports = router