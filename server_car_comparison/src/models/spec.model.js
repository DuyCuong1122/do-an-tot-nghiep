

const { ObjectId } = require('mongoose').Types;
const mongoose = require('mongoose');

const schema = mongoose.Schema;

const Specs = new schema({

    idCar: { type: ObjectId, required: true },
    category: { type: String, required: true },
    nameSpec: { type: String, required: true },
    value: { type: String, required: true },
    // unit: { type: String },
}, {versionKey: false, timestamps: true},);

const Spec = mongoose.model('Specs', Specs);

module.exports = { Spec }

