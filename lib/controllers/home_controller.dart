import 'package:get/get.dart';
import 'package:timberr/dummyData.dart';
import 'package:timberr/models/product.dart';

class HomeController extends GetxController {
  var selectedCategory = 0.obs;
  var productsList = <Product>[].obs;

  Future<void> changeCategory(int categoryId) async {
    if (selectedCategory.value == categoryId) return;
    selectedCategory.value = categoryId;
    await getProducts(categoryId);
  }

  Future<void> getProducts(int categoryId) async {
    final response = (categoryId == 0)
        ? dummyProducts.toList()
        : dummyProducts.where((a) => a.categoryId == categoryId).toList();
    productsList.value = response;
  }
}
