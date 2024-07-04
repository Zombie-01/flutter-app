import 'package:get/get.dart';
import 'package:timberr/models/category.dart';
import 'package:timberr/models/product.dart';
import 'package:timberr/services/api_service.dart';

class HomeController extends GetxController {
  var selectedCategory = 0.obs;
  var categories = <Category>[].obs;
  var productsList = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      List<Category> fetchedCategories = await ApiService.fetchCategories();
      categories.value = fetchedCategories;
      if (fetchedCategories.isNotEmpty) {
        await changeCategory(
            fetchedCategories[0].id); // Automatically select the first category
      }
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  Future<void> changeCategory(int categoryId) async {
    if (selectedCategory.value == categoryId) return;
    selectedCategory.value = categoryId;
    await getProducts(categoryId);
  }

  Future<void> getProducts(int categoryId) async {
    try {
      List<Product> fetchedProducts =
          await ApiService.fetchProductsByCategory(categoryId);
      productsList.value = fetchedProducts;
    } catch (e) {
      print("Error fetching products: $e");
    }
  }
}
