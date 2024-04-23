import 'dart:convert';

import 'package:compare_car/user/displayCar/state.dart';
import 'package:compare_car/common/entities/car.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:compare_car/common/config/config.dart';

class DisplayCarController extends GetxController {
  final DisplayCarState state = DisplayCarState();
  DisplayCarController();

  @override
  void onInit() {
    fetchCars();
    super.onInit();
  }

  Future<void> fetchCars() async {
    try {
      final response = await http.get(
        Uri.parse(carsURL),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
          "Access-Control-Allow-Headers": "Origin, Content-Type, X-Auth-Token",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> carList = jsonDecode(response.body);
        state.cars.value = carList.map((data) => Car.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load cars');
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
