import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/dummyData.dart';
import 'package:timberr/models/product.dart';

class FavoritesController extends GetxController {
  var favoritesList = <Product>[].obs;
  String token;

  FavoritesController({required this.token});

  Future<void> fetchFavorites() async {
    List responseList = [1, 2];
    for (int i = 0; i < responseList.length; i++) {
      final productResponse =
          dummyProducts.firstWhere((a) => a.productId == responseList[i]);
      favoritesList.add(productResponse);
    }
  }

  Future<void> updateDatabase() async {
    // await _supabaseClient.from('Users').update({
    //   'favoritesList':
    //       favoritesList.map((favoriteItem) => favoriteItem.productId).toList()
    // }).eq("Uid", _supabaseClient.auth.currentUser!.id);
  }

  Future<void> addProduct(Product product) async {
    favoritesList.add(product);
    await updateDatabase();
  }

  Future<void> removeProduct(Product product) async {
    favoritesList.remove(product);
    await updateDatabase();
  }

  Future<void> removeProductAt(int index) async {
    favoritesList.removeAt(index);
    await updateDatabase();
  }
}
