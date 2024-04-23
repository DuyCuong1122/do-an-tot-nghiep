const carRouter = require('./car');

function route(app)
{
    app.use('/', carRouter);

}

module.exports = route;