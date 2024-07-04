import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/wrapper.dart';

class AuthController extends GetxController {
  String? user;

  Future<void> signIn(String email, String password) async {
    try {
      if (email == "test@gmail.com" && password == "123456") {
        user = email; // Set user to email
        Get.offAll(() => const Wrapper(isAuth: true));
        return;
      }
      throw "Wrong password";
    } catch (error) {
      kDefaultDialog("Error", error.toString());
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      // Simulate sign up process
      if (email == "test@gmail.com") {
        throw "Email already exists";
      } else {
        user = email; // Set user to email
        Get.offAll(() => const Wrapper(isAuth: true));
      }
    } catch (error) {
      kDefaultDialog("Error", error.toString());
    }
  }

  Future<void> forgotPassword(String email) async {
    // Simulate password reset process
    if (email == "test@gmail.com") {
      Get.snackbar("Password reset",
          "Password reset request has been sent to your email successfully.");
    } else {
      Get.snackbar("Error", "Email not found.");
    }
  }
}
