

const mongoose = require('mongoose');

const schema = mongoose.Schema;

const Cars = new schema({
    nameCar: { type: String, required: true },
    release: { type: String, required: true },
    price: { type: Number, required: true },
    description: { type: String, required: true },
    showroom: { type: String },
    stateCar: { type: String, required: true },
    thumbnail: { type: String, required: true},
}, { versionKey: false, timestamps: true },);

const Car = mongoose.model('Cars', Cars);

module.exports = { Car }

