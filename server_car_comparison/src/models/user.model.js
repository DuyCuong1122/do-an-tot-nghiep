const mongoose = require("mongoose");

const User = mongoose.model(
  "Users",
  new mongoose.Schema({
    username: String,
    email: String,
    password: String,
    roles: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Roles"
      }
    ],
    googleId : String,
    displayName: {type: String, default: 'N'},
  },{versionKey: false, timestamps: true},)
);

module.exports = User;