const mongoose = require('mongoose');
const db = require("../models");
const Role = db.role;

async function connect() {
    try {
        await mongoose.connect('mongodb://127.0.0.1:27017/do_an_tot_nghiep');
        console.log('Connected successfully!!!');
        await initial();
    } catch (error) {
        console.error('Connection failed:', error.message);
    }
}

async function initial() {
    try {
        const count = await Role.estimatedDocumentCount();
        if (count === 0) {
            await Promise.all([
                new Role({ name: "user" }).save(),
                new Role({ name: "moderator" }).save(),
                new Role({ name: "admin" }).save()
            ]);
            console.log("Roles added to the roles collection");
        } else {
            console.log("Roles already exist in the roles collection");
        }
    } catch (error) {
        console.error('Error initializing roles:', error.message);
    }
}

module.exports = { connect };
