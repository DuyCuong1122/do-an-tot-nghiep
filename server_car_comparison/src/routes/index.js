const carRouter = require('./car.route');
const authRouter = require('./auth.route');
const userRouter = require('./user.route');


function route(app)
{
    app.use('/hehe',authRouter);
    app.use('/haha',userRouter);
    app.use('/', carRouter);
}

module.exports = route;