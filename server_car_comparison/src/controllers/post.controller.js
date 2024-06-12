const db = require('../models');
const { Post } = db.post;
const { User } = db.user;
const { Like } = db.like;
const { Comment } = db.comment;
const mongoose = require('mongoose');


class PostController {
    getAllPosts(req, res, next) {
        Post.aggregate([
            {
                $lookup: {
                    from: 'likes', // tên collection của Like
                    localField: '_id', // trường trong Post để kết nối với Like
                    foreignField: 'idPost', // trường trong Like để kết nối với Post
                    as: 'likes' // tên mảng kết quả chứa các like tương ứng
                }
            },
            {
                $lookup: {
                    from: 'comments', // tên collection của Comment
                    localField: '_id', // trường trong Post để kết nối với Comment
                    foreignField: 'idPost', // trường trong Comment để kết nối với Post
                    as: 'comments' // tên mảng kết quả chứa các comment tương ứng
                }
            },
            {
                $lookup: {
                    from: 'users', // tên collection của User
                    localField: 'idUser', // trường trong Post để kết nối với User
                    foreignField: '_id', // trường trong User để kết nối với Post
                    as: 'user' // tên mảng kết quả chứa thông tin user tương ứng
                }
            },
            {
                $project: { // Sử dụng $project để chỉ lấy các trường mong muốn
                    _id: 1,
                    title: 1,
                    content: 1,
                    idUser: 1,
                    displayName:{ $arrayElemAt: ['$user.username', 0] } ,
                    numberOfLikes: { $size: "$likes" }, // Đếm số lượng like
                    numberOfComments: { $size: "$comments" },
                    createdAt : 1// Đếm số lượng comment
                }
            }
        ])
        .then(posts => res.json(posts))
        .catch(err => { console.error(err); next(err) });
    }
    

    getPostByTitle(req, res, next) {
        const title = req.params.title;
    
        Post.aggregate([
            {
                $match: { title: title } // Lọc các post theo tiêu đề
            },
            {
                $lookup: {
                    from: 'likes',
                    localField: '_id',
                    foreignField: 'idPost',
                    as: 'likes'
                }
            },
            {
                $lookup: {
                    from: 'comments',
                    localField: '_id',
                    foreignField: 'idPost',
                    as: 'comments'
                }
            },
            {
                $lookup: {
                    from: 'users', // tên collection của User
                    localField: 'idUser', // trường trong Post để kết nối với User
                    foreignField: '_id', // trường trong User để kết nối với Post
                    as: 'user' // tên mảng kết quả chứa thông tin user tương ứng
                }
            },
            {
                $project: {
                    _id: 1,
                    title: 1,
                    content: 1,
                    displayName: { $arrayElemAt: ['$user.username', 0] },
                    numberOfLikes: { $size: "$likes" },
                    numberOfComments: { $size: "$comments" }
                }
            }
        ])
        .then(posts => {
            if (posts.length === 0) {
                return res.status(404).json({ message: 'Post not found' });
            }
            res.json(posts); // Trả về post đầu tiên (vì title được giả định là duy nhất)
        })
        .catch(err => { console.error(err); next(err) });
    }
    

    addPost(req, res, next) {
        const { idUser, content, title } = req.body;
        const post = new Post({ idUser, content, title });
        post.save()
            .then(() => res.status(201).send(post))
            .catch(err => { console.error(err); next(err) });
    }

    updatePost(req, res, next) {
        const id = req.params.id;
        const { idUser, content, title } = req.body;

        Post.findByIdAndUpdate(id, { idUser, content, title }, { new: true })
            .then(post => res.json(post))
            .catch(err => { console.error(err); next(err) });

    }

    deletePost(req, res, next) {
        const id = req.params.id;
        Post.findByIdAndDelete(id)
            .then(() => res.status(204).send())
            .catch(err => { console.error(err); next(err) });
    }

    getDetailPost(req, res, next) {
    const id = req.params.id; // Lấy id từ URL parameters

    let postId;
    try {
        postId = new mongoose.Types.ObjectId(id);
    } catch (error) {
        return res.status(400).json({ message: 'Invalid Post ID' });
    }

    Post.aggregate([
        {
            $match: { _id: postId } // Lọc post theo id
        },
        {
            $lookup: {
                from: 'likes',
                localField: '_id',
                foreignField: 'idPost',
                as: 'likes'
            }
        },
        {
            $lookup: {
                from: 'comments',
                localField: '_id',
                foreignField: 'idPost',
                as: 'comments'
            }
        },
        {
            $lookup: {
                from: 'users',
                localField: 'idUser',
                foreignField: '_id',
                as: 'author'
            }
        },
        {
            $lookup: {
                from: 'users',
                localField: 'comments.idUser',
                foreignField: '_id',
                as: 'commentAuthors'
            }
        },
        {
            $lookup:{
                from: 'users',
                localField: 'likes.idUser',
                foreignField: '_id',
                as: 'likeAuthors'
            }
        },
        {
            $project: {
                _id: 0,
                email: { $arrayElemAt: ['$author.username', 0] },
                content: 1,
                title: 1,
                likes: { $map: { input: '$likeAuthors', as: 'like', in: '$$like.username' } },
                comments: {
                    $map: {
                        input: '$comments',
                        as: 'comment',
                        in: {
                            
                            createAt : "$$comment.createdAt",
                            createBy: { $arrayElemAt: ['$commentAuthors.username', 0] },
                            content: '$$comment.content'
                        }
                    }
                },
                numberOfLikes: { $size: '$likes' },
                numberOfComments: { $size: '$comments' }
            }
        }
    ])
    .then(posts => {
        if (posts.length === 0) {
            return res.status(404).json({ message: 'Post not found' });
        }
        res.json(posts[0]);
    })
    .catch(err => { console.error(err); next(err) });
}

    

}

module.exports = new PostController();