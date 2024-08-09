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
        Uri.parse('$apiUrl/costumer/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String token = responseData['token'];
        if (token != null) {
          Get.offAll(() => Wrapper(isAuth: true, token: token));
        } else {
          kDefaultDialog("Error", "Failed to retrieve token");
        }
        return jsonDecode(response.body);
      } else {
        kDefaultDialog("Error", "Failed to sign in");
      }
    } catch (error) {
      kDefaultDialog("Error", error.toString());
    }
  }

  Future<void> signUp(String name, String phoneNumber, String lastName,
      String email, String password) async {
    try {
      // Simulate sign up process
      final response = await http.post(
        Uri.parse('$apiUrl/costumer/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'first_name': name,
          'last_name': lastName,
          'phone_number': phoneNumber,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String token = responseData['token'];
        if (token != null) {
          Get.offAll(() => Wrapper(isAuth: true, token: token));
        } else {
          kDefaultDialog("Error", "Failed to retrieve token");
        }
        return jsonDecode(response.body);
      } else {
        kDefaultDialog("Error", "Failed to sign up");
      }
    } catch (error) {
      kDefaultDialog("Error", error.toString());
    }
  }

  Future<void> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$apiUrl/costumer/forgotpassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    // Simulate password reset process
    if (response.statusCode == 200) {
      Get.snackbar("Password reset",
          "Password reset request has been sent to your email successfully.");
    } else {
      Get.snackbar("Error", "Email not found.");
    }
  }
}
