const config = require("../config/auth.config");
const db = require("../models");
const User = db.user;
const Role = db.role;

var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");

exports.signup = async (req, res) => {
  try {
    const user = new User({
      username: req.body.username,
      email: req.body.email,
      password: bcrypt.hashSync(req.body.password, 8)
    });

    await user.save();

    if (req.body.roles) {
      const roles = await Role.find({ name: { $in: req.body.roles } });
      user.roles = roles.map(role => role._id);
      await user.save();
    } else {
      const defaultRole = await Role.findOne({ name: "user" });
      user.roles = [defaultRole._id];
      await user.save();
    }

    res.status(201).send({ message: "User was registered successfully!" });
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: err.message || "An error occurred while registering the user." });
  }
};

exports.saveInfoGmail = async (req, res) => {
  try {
    const user = new User({
      username: req.body.username,
      email: req.body.email,

    });
    const defaultRole = await Role.findOne({ name: "user" });
    user.roles = defaultRole._id;
    await user.save();


    res.status(201).send({ message: "User was registered successfully!" });
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: err.message || "An error occurred while registering the user." });
  }
}

exports.signin = async (req, res) => {
  try {
    const user = await User.findOne({ username: req.body.username }).populate("roles", "-__v");

    if (!user) {
      return res.status(404).send({ message: "User Not found." });
    }

    const passwordIsValid = bcrypt.compareSync(req.body.password, user.password);

    if (!passwordIsValid) {
      return res.status(401).send({ accessToken: null, message: "Invalid Password!" });
    }

    const token = jwt.sign({ id: user.id }, config.secret, {
      algorithm: 'HS256',
      allowInsecureKeySizes: true,
      expiresIn: 86400, // 24 hours
    });

    const authorities = user.roles.map(role => "ROLE_" + role.name.toUpperCase());

    res.status(200).send({
      id: user._id,
      username: user.username,
      email: user.email,
      roles: authorities,
      access_token: token,
      displayName: user.displayName,
    });
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: err.message || "An error occurred while signing in." });
  }
};

exports.signinWithGoogle = async (req, res) => {
  try {
    const { email, googleId } = req.body;
    let user = await User.findOne({ googleId });
    if (!user) {
      user = new User({ email, googleId });
      const defaultRole = await Role.findOne({ name: "user" });
      user.roles = [defaultRole._id];
      await user.save();
    }
    const token = jwt.sign({ id: user.id }, config.secret, {
      algorithm: 'HS256',
      allowInsecureKeySizes: true,
      expiresIn: 86400, // 24 hours
    });
    res.status(200).send({ token });
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: err.message || "An error occurred while signing in." });
  }
}