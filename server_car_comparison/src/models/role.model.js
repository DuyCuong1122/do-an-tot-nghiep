const mongoose = require("mongoose");

const Role = mongoose.model(
  "Roles",
  new mongoose.Schema({
    name: String
  })
);

module.exports = Role;