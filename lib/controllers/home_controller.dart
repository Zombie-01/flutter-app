import 'package:get/get.dart';
import 'package:timberr/models/category.dart';
import 'package:timberr/models/product.dart';
import 'package:timberr/services/api_service.dart';

class HomeController extends GetxController {
  var selectedCategory = RxnInt();
  var categories = <Category>[].obs;
  var productsList = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    getProducts();
  }

  Future<void> fetchCategories() async {
    try {
      List<Category> fetchedCategories = await ApiService.fetchCategories();
      categories.value = fetchedCategories;
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  Future<void> changeCategory(int categoryId) async {
    if (selectedCategory.value == categoryId) return;
    selectedCategory.value = categoryId;
    await getProductsById(categoryId);
  }

  Future<void> getProducts() async {
    try {
      List<Product> fetchedProducts = await ApiService.fetchProducts();
      productsList.value = fetchedProducts;
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<void> getProductsById(int categoryId) async {
    try {
      List<Product> fetchedProducts =
          await ApiService.fetchProductsByCategory(categoryId!);
      productsList.value = fetchedProducts;
    } catch (e) {
      print("Error fetching products: $e");
    }
  }
}
