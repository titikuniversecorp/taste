
// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../screens/cart/cart_screen.dart';
import '../services/repositories/cart_repo.dart';

class CartController extends GetxController {
  CartController({required this.cartRepo});

  final CartRepo cartRepo;

  final Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity) {
    Vibrate.feedback(FeedbackType.impact);
    if (quantity <= 0) {
      _items.remove(product.id);
    }
    else {
      if (_items.containsKey(product.id)) {
        _items.update(product.id, (value) => CartModel(
          product: value.product,
          quantity: quantity,
          isExist: true
        ));
      }
      else {
        _items.putIfAbsent(product.id, () {
          return CartModel(
            product: product,
            quantity: quantity,
            isExist: true
          );
        });
      }
    }
    
    update();
    if (_items.isEmpty) {
      if (cartIsOpen) Navigator.of(Get.context!).pop();
    }
  }

  int getTotalWeight() {
    int weight = 0;
    _items.forEach((key, value) {
      weight += value.product.weight * value.quantity;
    });
    return weight;
  }

  String getTotalWeightAsFormattedString() {
    int weight = getTotalWeight();
    if (weight < 1000) return '$weight г';
    else {
      double weightInKg = weight / 1000;
      return '${weightInKg.toStringAsFixed(3).replaceFirst('.', ' ')} г';
    }
  }

  double getTotalPrice() {
    double price = 0;
    _items.forEach((key, value) {
      price += value.product.price * value.quantity;
    });
    return price;
  }

  int getProductQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity;
        }
      });
    }
    return quantity;
  }

  void setProductQuantity(ProductModel product, bool isAdd) {
    final quantity = getProductQuantity(product);
    int newQuantity = isAdd ? _checkQuantity(quantity + 1) : _checkQuantity(quantity - 1);
    addItem(product, newQuantity);
  }

  int _checkQuantity(int value) {
    if (value < 0) {
      Vibrate.feedback(FeedbackType.error);
      // Get.snackbar('Ой...', 'Вы не можете убавить ещё', backgroundColor: MyTheme.of(Get.context!).brandColor, colorText: Colors.black, icon: const Icon(Icons.error_outline));
      return 0;
    }
    else if (value > 20) {
      Vibrate.feedback(FeedbackType.error);
      // Get.snackbar('Ой...', 'Вы не можете добавить ещё', backgroundColor: MyTheme.of(Get.context!).brandColor, colorText: Colors.black, icon: const Icon(Icons.error_outline));
      return 20;
    }
    else return value;
  }
}