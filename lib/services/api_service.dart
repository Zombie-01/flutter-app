import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:timberr/constants.dart';
import 'package:timberr/models/category.dart';
import 'package:timberr/models/product.dart';

class ApiService {
  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$apiUrl/category/client'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    final response = await http
        .get(Uri.parse('$apiUrl/products/mobile?category=$categoryId'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
