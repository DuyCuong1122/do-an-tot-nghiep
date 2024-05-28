import 'dart:convert';
import 'dart:developer';

import 'package:compare_car/common/config/config.dart';
import 'package:compare_car/user/compareCar/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../common/entities/entities.dart';

class CompareController extends GetxController {
  CompareController();
  final CompareState state = CompareState();
  final TextEditingController car1Controller = TextEditingController();
  final TextEditingController car2Controller = TextEditingController();
  Map<dynamic, dynamic> tmp = <dynamic, dynamic>{};
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getInfo2Cars() async {
    final car1 = car1Controller.text;
    final car2 = car2Controller.text;
    final url = '$compareCarURL?car1=$car1&car2=$car2';

    print(url);
    try {
      final response = await http.get(
        Uri.parse(Uri.encodeFull(url)),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
          "Access-Control-Allow-Headers": "Origin, Content-Type, X-Auth-Token",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> parsedJson = jsonDecode(response.body);
        List<Comparison> comparisons =
            parsedJson.map((json) => Comparison.fromJson(json)).toList();

        // Print out the comparisons for verification
        comparisons.forEach((comparison) {
          comparison.specs1.forEach((spec) {
            tmp[spec.specName] = spec.category;
          });
          comparison.specs2.forEach((spec) {
            tmp[spec.specName] = spec.category;
          });
        });
        tmp.forEach((key, value) {
          log('key: $key, value: $value');
          log('------------------');
          state.specs[value] = key;
        });
        state.specs.forEach((key, value) {
          log('key: $key, value: $value');
        });
        Get.snackbar(
          'Success',
          'Car found successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );
      } else {
        Get.snackbar(
          'error',
          'Failed to get cars info',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        throw Exception('Failed to get cars info');
      }
    } catch (e) {
      log("error: $e");
    }
  }
}
