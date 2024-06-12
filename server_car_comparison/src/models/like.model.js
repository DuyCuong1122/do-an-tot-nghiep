

const { ObjectId } = require('mongoose').Types;
const mongoose = require('mongoose');

const schema = mongoose.Schema;

const Likes = new schema({

    idPost: { type: ObjectId, required: true },
    idUser: { type: ObjectId, required: true },
    // unit: { type: String },
}, {versionKey: false, timestamps: true},);

const Like = mongoose.model('Likes', Likes);

module.exports = { Like }

