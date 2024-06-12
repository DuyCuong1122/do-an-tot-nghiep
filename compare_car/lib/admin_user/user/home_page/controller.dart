import 'dart:convert';
import 'dart:developer';
import 'package:compare_car/common/entities/car.dart';
import 'package:compare_car/admin_user/user/home_page/state.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../common/config/config.dart';

class HomeController extends GetxController {
  HomeState state = HomeState();
  final search = TextEditingController();

  void setSelected(String value) {
    state.selectedValue.value = value;
  }

  void selectCarType(String type) {
    state.selectedCarType.value = type;
  }

  void getSuggestions(String query) async {
    log(query);
    if (query.isEmpty) {
      state.suggestions.clear();
      return;
    }

    final response = await http.get(Uri.parse(searchCarURL + query));
    if (response.statusCode == 200) {
      state.suggestions.assignAll(json.decode(response.body));
    } else {
      Get.snackbar('Error', 'Failed to load suggestions');
    }
  }

  void fetchCars() async {
    state.cars.clear();
    try {
      final response = await http.get(
        Uri.parse(searchCarURL + state.selectedValue.toString()),
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
      Get.snackbar('Error', 'Failed to load cars: $e');
    }
  }

  Future<void> fetchAllCars() async {
    state.cars.clear();
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
      Get.snackbar('Error', 'Failed to load cars: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllCars();
  }
}
