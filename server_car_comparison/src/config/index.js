const mongoose = require('mongoose');
const db = require("../models");
const Role = db.role;

async function connect() {
    try {
        await mongoose.connect('mongodb+srv://minastik:cuong1122@doantotnghiep.8pkytnn.mongodb.net/do_an_tot_nghiep?retryWrites=true&w=majority');
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

// function initial() {
//     // The estimatedDocumentCount() function is quick as it estimates the number of documents in the MongoDB collection. It is used for large collections because this function uses collection metadata rather than scanning the entire collection.
  
//     Role.estimatedDocumentCount((err, count) => {
//       if (!err && count === 0) {
//         new Role({
//           name: "user",
//         }).save((err) => {
//           if (err) {
//             console.log("error", err);
//           }
  
//           console.log("added 'user' to roles collection");
//         });
  
//         new Role({
//           name: "moderator",
//         }).save((err) => {
//           if (err) {
//             console.log("error", err);
//           }
  
//           console.log("added 'moderator' to roles collection");
//         });
  
//         new Role({
//           name: "admin",
//         }).save((err) => {
//           if (err) {
//             console.log("error", err);
//           }
  
//           console.log("added 'admin' to roles collection");
//         });
//       }
//     });
//   }

  module.exports = { connect, initial };