const { ObjectId } = require('mongoose').Types;
const mongoose = require('mongoose');

const schema = mongoose.Schema;

const Images = new schema({

    idCar: { type: ObjectId, required: true },
    exterior: [{ type: String }],
    interior: [{ type: String }],
    color: [{ type: String }],
}, {versionKey: false, timestamps: true},);

const Image = mongoose.model('Images', Images);

module.exports = { Image }

