const express = require('express');
const app = express();
const route = require('./src/routes');
const mongoose = require('mongoose');
const db = require('./src/config');
const PORT = 3000;
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(function (req, res, next) {
    res.header("Content-Type", 'application/json');
    res.header("Access-Control-Allow-Origin", "*");
    next();
  });
db.connect();
db.initial();
route(app);

app.listen(PORT, () => {
    console.log(`App listening at http://localhost:${PORT}`)
});


