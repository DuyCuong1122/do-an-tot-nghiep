const mongoose = require('mongoose');
mongoose.Promise = global.Promise;

const db = {};

db.mongoose = mongoose;

db.user = require("./user.model");
db.role = require("./role.model");
db.car = require("./car.model");
db.spec = require("./spec.model");
db.image = require("./image.model");


db.ROLES = ["user", "admin", "moderator"];

module.exports = db;