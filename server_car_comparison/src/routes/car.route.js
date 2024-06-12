const express = require('express');
const router = express.Router();
const carController = require('../controllers/car.controller');
const upload = require('../middleware/upload');

var imageFileUpload = upload.fields([{ name: 'exterior'}, { name: 'interior'}, { name: 'color'}]);

router.get('/search', carController.searchCar)
router.get('/cars/:year', carController.getCarByYear);
router.post('/image', imageFileUpload, carController.addImage);
router.get('/compare', carController.compareCar);
router.post('/spec', carController.addSpec);
router.delete('/spec', carController.deleteSpec);
router.get('/cars', carController.getAllCars);
router.get('/car', carController.getCarByName);
router.post('/car', upload.single('thumbnail'), carController.createCar);
router.put('/car/:id', carController.updateCar);
router.delete('/car/:name', carController.deleteCar);
router.get('/', (req, res) => res.send('Hello World'));



module.exports = router;
