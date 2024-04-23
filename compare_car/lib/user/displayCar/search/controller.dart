import 'dart:convert';

import 'package:compare_car/common/entities/car.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:compare_car/common/config/config.dart';

import 'state.dart';

class SearchCarController extends GetxController {
  final SearchCarState state = SearchCarState();
  SearchCarController();

  RxList<Car> cars = <Car>[].obs;

  @override
  void onInit() {
    fetchCars();
    super.onInit();
  }

  // Future<Car?> fetchCars() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(carsURL),
  //       headers: {
  //         "Access-Control-Allow-Origin": "*",
  //         "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
  //         "Access-Control-Allow-Headers": "Origin, Content-Type, X-Auth-Token",
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       List<dynamic> carList = jsonDecode(response.body);
  //       cars.value = carList.map((data) => Car.fromJson(data)).toList();
  //       // cars = Car.fromJson(jsonDecode(response.body) as Map<String, dynamic>) as List<Car>;
  //       print(cars);
  //       // return cars;
  //     } else {
  //       throw Exception('Failed to load cars');
  //     }
  //   } catch (e) {
  //     print("error: " + e.toString());
  //     return null;
  //   }
  // }
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
        cars.value = carList.map((data) => Car.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load cars');
      }
    } catch (e) {
      print("error: " + e.toString());
    }
  }
}
