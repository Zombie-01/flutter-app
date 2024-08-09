import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/dummyData.dart';
import 'package:timberr/models/cart_item.dart';
import 'package:timberr/models/product.dart';
import 'package:timberr/screens/cart/cart_screen.dart';

class CartController extends GetxController {
  List<int> cartIdList = [];
  var cartList = <CartItem>{}.obs;
  var total = 0.obs;
  String token;

  CartController({required this.token});

  Future<void> fetchCartItems() async {
    cartIdList = dummyCartItems.map((item) => item.cartId).toList();
    for (int i = 0; i < cartIdList.length; i++) {
      final cartResponse =
          dummyCartItems.firstWhere((a) => a.cartId == cartIdList[i]);
      cartList.add(cartResponse);
      total.value +=
          (cartList.elementAt(i).quantity * cartList.elementAt(i).price);
    }
  }

  int findProduct(Product product, Color color) {
    for (int i = 0; i < cartList.length; i++) {
      if (cartList.elementAt(i).productId == product.productId &&
          cartList.elementAt(i).color == color) {
        return i;
      }
    }
    return -1;
  }

  Future<void> addToCart(Product product, Color color,
      {int quantity = 1, bool showSnackbar = true}) async {
    int index = findProduct(product, color);
    if (index != -1) {
      // Product already present in cart
      cartList.elementAt(index).addQuantity(quantity);
      total.value += (quantity * cartList.elementAt(index).price);
    } else {
      // Product not there in cart
      int newCartId = cartIdList.isEmpty ? 1 : cartIdList.last + 1;
      CartItem newItem = CartItem(
        newCartId,
        quantity,
        colorToString(color),
        product.toJson(),
      );
      cartList.add(newItem);
      total.value += (quantity * product.price);
      cartIdList.add(newCartId);
    }
    if (showSnackbar) {
      Get.snackbar(
        "Added to Cart",
        "${product.name} has been added to the cart",
        onTap: (_) {
          Get.closeCurrentSnackbar();
          Get.to(
            () => CartScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 600),
          );
        },
      );
    }
  }

  Future<void> removeFromCart(CartItem item) async {
    cartList.remove(item);
    cartIdList.remove(item.cartId);
    total.value -= (item.quantity * item.price);
  }

  Future<void> incrementQuantity(CartItem item) async {
    item.addQuantity(1);
    total.value += item.price;
    update();
  }

  Future<void> decrementQuantity(CartItem item) async {
    if (item.quantity == 1) {
      await removeFromCart(item);
    } else {
      item.removeQuantity(1);
      total.value -= item.price;
      update();
    }
  }

  Future<void> removeAllFromCart() async {
    cartList.clear();
    cartIdList.clear();
    total.value = 0;
  }
}
