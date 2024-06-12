

const { ObjectId } = require('mongoose').Types;
const mongoose = require('mongoose');

const schema = mongoose.Schema;

const Posts = new schema({

    idUser: { type: ObjectId, required: true },
    content: { type: String, required: true },
    title: { type: String, required: true },
    // unit: { type: String },
}, {versionKey: false, timestamps: true},);

const Post = mongoose.model('Posts', Posts);

module.exports = { Post }

