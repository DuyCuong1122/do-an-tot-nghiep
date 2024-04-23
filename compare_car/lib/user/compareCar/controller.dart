import 'dart:convert';

import 'package:compare_car/common/config/config.dart';
import 'package:compare_car/common/entities/car.dart';
import 'package:compare_car/user/compareCar/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompareController extends GetxController {
  CompareController();
  final CompareState state = CompareState();
  final TextEditingController car1Controller = TextEditingController();
  final TextEditingController car2Controller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getInfo2Cars() async {
    final car1 = car1Controller.text;
    final car2 = car2Controller.text;
    try {
      final response = await http.get(
        Uri.parse('$carsURL?car1=$car1&car2=$car2'),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
          "Access-Control-Allow-Headers": "Origin, Content-Type, X-Auth-Token",
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        state.cars.value =
            data.map((carJson) => Car.fromJson(carJson)).toList();
      } else {
        throw Exception('Failed to get cars info');
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
