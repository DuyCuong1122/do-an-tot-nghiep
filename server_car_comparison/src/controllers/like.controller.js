const db = require('../models');

const { Like } = db.like;

class LikeController {
    getAllLikes(req, res, next) {
        Like.find({})
            .then(likes => res.json(likes))
            .catch(err => { console.error(err); next(err) });
    }

    getLikeByPostId(req, res, next) {
        const idPost = req.params.idPost;
        console.log(idPost);
        try {
            var likes = Like.find({ idPost: idPost });
            if (!likes) {
                return res.status(404).json({ message: 'Like not found' });
            }
        } catch (err) {
            console.error(err);
            res.status(500).json({ message: 'Server error' });
        }
    }

    async LikeOrNot(req, res, next) {
        const { idPost, idUser } = req.body;

        try {
            const isLike = await Like.findOne({ idPost, idUser });
            if (isLike) {
                await Like.findByIdAndDelete(isLike._id);
                return res.status(200).send("unliked");
            }

            const like = new Like({ idPost, idUser });
            await like.save();
            res.status(201).send(like);
        } catch (err) {
            console.error(err);
            next(err);
        }
    }


    updateLike(req, res, next) {
        const id = req.params.id;
        const { idPost, idUser } = req.body;

        Like.findByIdAndUpdate(id, { idPost, idUser }, { new: true })
            .then(like => res.json(like))
            .catch(err => { console.error(err); next(err) });

    }

    checkLike(req, res, next) {
        const { idPost, idUser } = req.body;
        Like.findOne({ idPost, idUser })
            .then(like => {
                if (like) {
                    return res.status(200).json({"isLiked" :"true"});
                }
                res.status(200).json({"isLiked" :"false"});
            })
            .catch(err => { console.error(err); next(err) });
    }

}

module.exports = new LikeController();