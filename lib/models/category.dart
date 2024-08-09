import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:timberr/constants.dart';

class Category {
  int id;
  String category_name;

  Category({required this.id, required this.category_name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      category_name: json['category_name'],
    );
  }
}

Future<List<Category>> fetchCategories() async {
  final response = await http.get(Uri.parse('$apiUrl/category/client'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}
