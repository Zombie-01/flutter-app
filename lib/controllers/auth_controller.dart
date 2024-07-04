import 'package:get/get.dart';
import 'dart:convert';
import 'package:timberr/constants.dart';
import 'package:timberr/wrapper.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  String? user;

  Future<void> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        Get.offAll(() => const Wrapper(isAuth: true));
        return jsonDecode(response.body);
      } else {
        kDefaultDialog("Error", "Failed to sign in");
      }
    } catch (error) {
      kDefaultDialog("Error", error.toString());
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      // Simulate sign up process
      final response = await http.post(
        Uri.parse('$apiUrl/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'username': name,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        Get.offAll(() => const Wrapper(isAuth: true));
        return jsonDecode(response.body);
      } else {
        kDefaultDialog("Error", "Failed to sign up");
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
