// Đây là nơi chứa các hàm xử lý logic của các API liên quan đến việc quản lý thông tin của xe
const db = require('../models');
const { Car } = db.car;
const { Spec } = db.spec;
const { Image } = db.image;

class CarController {
  getAllCars(req, res, next) {
    Car.find({})
      .then(cars => res.json(cars))
      .catch(err => { console.error(err); next(err) });
  }

  async getCarByName(req, res, next) {
    try {
      // Lấy tên xe từ phần thân của yêu cầu
      // const { nameCar } = req.body;
      const nameCar = req.query.nameCar;
      // Tìm kiếm xe trong cơ sở dữ liệu
      const car = await Car.findOne({ nameCar: nameCar });
      const specs = await Spec.find({ idCar: car._id });
      const images = await Image.find({ idCar: car._id });
      if (!car) {
        // Trả về phản hồi 404 nếu không tìm thấy xe
        return res.status(404).json({ message: 'Car not found' });
      }

      // Trả về thông tin của xe nếu tìm thấy
      res.status(200).send({ car, specs, images });
    } catch (err) {
      // Xử lý lỗi nếu có
      console.error(err);
      res.status(500).json({ message: 'Server error' });
    }
  }

  async createCar(req, res) {
    try {
      // var readFile = Buffer.from(req.body.thumbnail, 'base64')
      // fs.writeFileSync(req.body.nameImage, readFile, "utf8");
      // // console.log(req.body);
      // console.log(req.body.nameImage + "hehe");
      if (!req.file) {
        return res.status(400).send('No files were uploaded.');
      }
      const imagePath = req.file.path;
      const car = new Car({
        nameCar: req.body.nameCar,
        release: req.body.release,
        price: req.body.price,
        description: req.body.description,
        showroom: req.body.showroom,
        stateCar: req.body.stateCar,
        thumbnail: req.file.path,
      });
      console.log(car);


      const existingCar = await Car.findOne({ nameCar: car.nameCar });

      if (existingCar) {
        // Nếu có, trả về lỗi cho máy khách
        return res.status(400).json({ error: 'Car with this name already exists' });
      }
      await car.save();
      res.status(201).send(car);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  updateCar(req, res) {
    let carIndex = allCars.flat().findIndex(car => car.id == req.params.id);
    if (carIndex !== -1) {
      allCars.flat()[carIndex] = { ...allCars.flat()[carIndex], ...req.body };
      res.status(200).json(allCars.flat()[carIndex]);
    } else {
      res.status(404).json({ message: 'Car not found' });
    }
  }
  year
  async deleteCar(req, res) {
    try {
      const name = req.params.name;
      console.log("hehe " + req.params.name)
      // Tìm ID của xe dựa trên tên
      const car = await Car.findOne({ nameCar: name });

      if (!car) {
        return res.status(404).send('Car not found');
      }

      // Xóa các bản ghi từ bảng "specs" có id_Car tương ứng với ID của xe
      const deletedSpecs = await Spec.deleteMany({ idCar: car._id });

      // Sau đó, xóa bản ghi từ bảng "cars"
      const deletedCar = await Car.findOneAndDelete({ nameCar: name });

      res.status(200).send('Car and related specs deleted successfully');
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal server error');
    }
  }

  async compareCar(req, res) {
    const nameCar1 = req.query.car1;
    const nameCar2 = req.query.car2;
    console.log(nameCar1, '\n', nameCar2);
    // Tìm thông tin của 2 xe
    try {


      const car1 = await Car.findOne({ nameCar: nameCar1 });
      const car2 = await Car.findOne({ nameCar: nameCar2 });


      if (!car1 || !car2) {
        return res.status(404).json({ message: 'Car not found' });
      }

      const specs1 = await Spec.find({ idCar: car1._id });
      const specs2 = await Spec.find({ idCar: car2._id });
      // const images1 = await Image.find({ idCar: car1._id });
      // const images2 = await Image.find({ idCar: car1._id });

      res.json([{ car1, specs1, car2, specs2 }]);
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Server error' });
    }
  }

  async addSpec(req, res, next) {
    try {
      const { nameCar } = req.body;
      const car = await Car.findOne({ nameCar: nameCar })
      if (!car) {
        return res.status(404).json({ message: 'Car not found' });
      }
      var existingSpec = await Spec.findOne({ category: req.body.category, nameSpec: req.body.nameSpec })
      if (existingSpec) {
        return res.status(400).json({ message: 'Spec already exists' });
      }
      const spec = new Spec({
        idCar: car._id,
        category: req.body.category,
        nameSpec: req.body.nameSpec,
        value: req.body.value,
        unit: req.body.unit
      });

      await spec.save();
      res.status(201).send(spec);
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Server error' });
    }
  }

  async updateSpec(req, res, next) {

  }

  async getCarByYear(req, res, next) {
    const year = parseInt(req.params.year);
    console.log(year);
    try {


      // Tìm kiếm xe trong cơ sở dữ liệu
      var cars = Car.find({ release: year });
      if (!cars) {
        // Trả về phản hồi 404 nếu không tìm thấy xe
        return res.status(404).json({ message: 'Car not found' });
      }

      // Trả về thông tin của xe nếu tìm thấy
      // res.status(200).send(cars);
    } catch (err) {
      // Xử lý lỗi nếu có
      console.error(err);
      res.status(500).json({ message: 'Server error' });
    }
  }

  async deleteSpec(req, res, next) {
    try {
      console.log("hehe" + req.body)
      var deleteItem = req.body;
      // Tìm ID của xe dựa trên tên
      const car = await Car.findOne({ nameCar: deleteItem.nameCar });

      if (!car) {
        return res.status(404).send('Car not found');
      }

      // Xóa các bản ghi từ bảng "specs" có id_Car tương ứng với ID của xe
      const deletedSpecs = await Spec.deleteMany({ idCar: car._id, category: deleteItem.category, nameSpec: deleteItem.nameSpec });

      if (!deletedSpecs) {
        return res.status(400).send('Spec not found');
      }

      res.status(200).send('Car and related specs deleted successfully');
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal server error');
    }
  }

  async addImage(req, res, next) {
    try {
      var colorImages = [];
      var exteriorImages = [];
      var interiorImages = [];
      if (req.files['color']) {
        colorImages = req.files['color'].map(file => file.path);
      }
      if (req.files['exterior']) {
        exteriorImages = req.files['exterior'].map(file => file.path);
      }
      if (req.files['interior']) {
        interiorImages = req.files['interior'].map(file => file.path);
      }
      console.log(exteriorImages, interiorImages, colorImages, req.body.nameCar);
      const car = await Car.findOne({ nameCar: req.body.nameCar });

      if (!car) {
        return res.status(404).send('Car not found');
      }

      const image = new Image({
        idCar: car._id,
        exterior: exteriorImages,
        interior: interiorImages,
        color: colorImages
      });
      await image.save();
      res.status(201).json({ requestBody: req.body, uploadedFiles: req.files });

    } catch (error) {
      console.error(error);
      res.status(500).send('Can not upload file');
    }
  }

  async searchCar(req, res, next) {
    const searchTerm = req.query.nameCar; // Lấy tham số 'search' từ query string
    if (!searchTerm) {
      return res.status(400).send('Search query parameter is required');
    }

    // Tìm kiếm xe trong cơ sở dữ liệu
    const regex = new RegExp(searchTerm, 'i'); // 'i' để không phân biệt chữ hoa chữ thường
    Car.find({ nameCar: { $regex: regex } })
      .then(cars => res.json(cars))
      .catch(err => { console.error(err); next(err) });
  }
}



module.exports = new CarController();
