const db = require('../models');

const { Comment } = db.comment;

class CommentController {
    getAllComments(req, res, next) {
        Comment.find({})
            .then(comments => res.json(comments))
            .catch(err => { console.error(err); next(err) });
    }

    getCommentByPostId(req, res, next) {
        const idPost = req.params.idPost;
        console.log(idPost);
        try {
            var comments = Comment.find({ idPost: idPost });
            if (!comments) {
                return res.status(404).json({ message: 'Comment not found' });
            }
        } catch (err) {
            console.error(err);
            res.status(500).json({ message: 'Server error' });
        }
    }

    addComment(req, res, next) {
        const { idPost, idUser, content } = req.body;
        const comment = new Comment({ idPost, idUser, content });
        comment.save()
            .then(() => res.status(201).send(comment))
            .catch(err => { console.error(err); next(err) });
    }

    updateComment(req, res, next) {
        const id = req.params.id;
        const { idPost, idUser, content } = req.body;

        Comment.findByIdAndUpdate(id, { idPost, idUser, content }, { new: true })
            .then(comment => res.json(comment))
            .catch(err => { console.error(err); next(err) });

    }

    deleteComment(req, res, next) {
        const id = req.params.id;
        Comment.findByIdAndDelete(id)
            .then(() => res.status(204).send())
            .catch(err => { console.error(err); next(err) });
    }
}

module.exports = new CommentController();