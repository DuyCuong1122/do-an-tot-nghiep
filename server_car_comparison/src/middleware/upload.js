const path = require('path');
const multer = require('multer');
const fs = require('fs');



const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        if (req.body.nameCar) {
            const nameCar = req.body.nameCar;
            const uploadPath = path.join('src/uploads', nameCar);
            if (!fs.existsSync(uploadPath)) {
                // Nếu thư mục chưa tồn tại, tạo thư mục mới
                fs.mkdirSync(uploadPath, { recursive: true }, (err) => {
                    if (err) {
                        console.error('Error creating directory:', err);
                    } else {
                        console.log('Directory created successfully');
                    }
                });
            } else {
                console.log('Directory already exists');
            }
            cb(null, uploadPath);
            return;
        }
        cb(null, 'src/uploads/')
    },
    filename: function (req, file, cb) {
        let ext = path.extname(file.originalname);
        if (req.body.nameCar) {
            const nameCar = req.body.nameCar;
            cb(null, nameCar + "_" + Date.now() + ext);
            return;
        }

        cb(null, Date.now() + ext);
    }
})

const upload = multer({
    storage: storage,
})

module.exports = upload