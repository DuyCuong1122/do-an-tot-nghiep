import 'dart:io';

import 'package:compare_car/common/config/config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:compare_car/admin_user/admin/addCar/state.dart';
import 'package:get/get.dart';

class AddCarController extends GetxController {
  final AddCarState state = AddCarState();
  AddCarController();
  final TextEditingController nameCarController = TextEditingController();
  // final TextEditingController thumbnailController = TextEditingController();
  final TextEditingController releaseController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController showroomController = TextEditingController();
  final TextEditingController stateCarController = TextEditingController();

  Future<void> createCar() async {
    try {
      String nameCar = nameCarController.text;
      String release = releaseController.text;
      String price = priceController.text;
      String description = descriptionController.text;
      // String thumbnail = thumbnailController.text;
      String showroom = showroomController.text;
      String stateCar = stateCarController.text;
      String fileName = state.file.value!.path.split("/").last;

      print('nameCar: $nameCar');
      print('release: $release');
      print('price: $price');
      print('description: $description');
      print('showroom: $showroom');
      print('stateCar: $stateCar');
      print('thumbnail: $fileName');

      final request = http.MultipartRequest('POST', Uri.parse(carURL))
        ..fields['nameCar'] = nameCar
        ..fields['release'] = release
        ..fields['price'] = price
        ..fields['description'] = description
        ..fields['showroom'] = showroom
        ..fields['stateCar'] = stateCar
        ..files.add(http.MultipartFile.fromBytes(
            'thumbnail', state.file.value!.readAsBytesSync(),
            filename: fileName));

      var response = await request.send();

      if (response.statusCode == 201) {
        print('Car added successfully');
        Get.snackbar(
          'Success',
          'Car added successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );

        // Xóa dữ liệu trên các trường nhập liệu
        nameCarController.clear();
        releaseController.clear();
        priceController.clear();
        descriptionController.clear();
        // thumbnailController.clear();
        state.file.value = null;
        showroomController.clear();
        stateCarController.clear();
      } else if (response.statusCode == 400) {
        Get.snackbar(
          'Error',
          'Car with this name already exists',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        print('Car with this name already exists');
        throw Exception('Car with this name already exists');
      } else {
        print('Failed to create car');
        Get.snackbar(
          'Error',
          'Failed to create car',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        throw Exception('Failed to create car');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Lấy đường dẫn của tệp đã chọn
      state.file.value = File(result.files.single.path!);
    }
  }
}
