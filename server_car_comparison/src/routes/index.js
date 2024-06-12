const carRouter = require('./car.route');
const authRouter = require('./auth.route');
const userRouter = require('./user.route');
const postRouter = require('./post.route');
const likeRouter = require('./like.route');
const commentRouter = require('./comment.route');
function route(app)
{
    app.use('/user',authRouter);
    app.use('/user',userRouter);
    app.use('/', carRouter);
    app.use('/', postRouter);
    app.use('/', likeRouter);
    app.use('/', commentRouter);
}

module.exports = route;