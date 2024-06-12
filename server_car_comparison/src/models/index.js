const mongoose = require('mongoose');
mongoose.Promise = global.Promise;

const db = {};

db.mongoose = mongoose;

db.user = require("./user.model");
db.role = require("./role.model");
db.ROLES = ["user", "admin", "moderator"];
db.car = require("./car.model");
db.spec = require("./spec.model");
db.image = require("./image.model");
db.post = require("./post.model");
db.like = require("./like.model");
db.comment = require("./comment.model");




module.exports = db;