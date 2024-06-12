import 'dart:developer';

import 'package:compare_car/common/config/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUp() async {
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    const url = sign_up;

    print(url);
    try {
      final response =
          await http.post(Uri.parse(Uri.encodeFull(url)), headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
        "Access-Control-Allow-Headers": "Origin, Content-Type, X-Auth-Token",
      }, body: {
        "username": username,
        "email": email,
        "password": password,
      });
      log({"username": username, "email": email, "password": password}
          .toString());

      if (response.statusCode == 201) {
        // Print out the comparisons for verification

        Get.snackbar(
          'Sign Up',
          'Sign-up successful!',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAndToNamed('/sign_in');
      } else {
        Get.snackbar(
          'error',
          'Failed to Sign-up ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        throw Exception('Failed to Sign-up ');
      }
    } catch (e) {
      log("error: $e");
    }
  }
  // Perform sign-up logic here
}
