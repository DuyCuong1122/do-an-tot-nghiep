

const { ObjectId } = require('mongoose').Types;
const mongoose = require('mongoose');

const schema = mongoose.Schema;

const Comments = new schema({

    idPost: { type: ObjectId, required: true },
    idUser: { type: ObjectId, required: true },
    content: { type: String, required: true },
    // unit: { type: String },
}, {versionKey: false, timestamps: true},);

const Comment = mongoose.model('Comments', Comments);

module.exports = { Comment }

