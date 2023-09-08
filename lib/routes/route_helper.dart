import 'package:get/get.dart';
import 'package:taste/screens/cart/cart_screen.dart';

import '../screens/home/home_screen.dart';
import '../screens/category/category_view_screen.dart';
import '../screens/intro_screen.dart';
import '../screens/product_screen.dart';

class RouteHelper {
  static const String _initial = '/';
  static const String _catalog = '/catalog';
  static const String _category = '/category';
  static const String _product = '/product';
  static const String _cart = '/cart';

  static String initial() => _initial;
  static String catalog() => _catalog;
  static String category(int categoryId) => '$_category?cId=$categoryId';
  static String product(int productId) => '$_product?pId=$productId';
  static String cart() => _cart;


  static List<GetPage> routes = [
    GetPage(name: _initial, page: () => const IntroScreen()),
    GetPage(name: _catalog, page: () => const HomeScreen()),
    GetPage(name: _category, page: () {
      int categoryId = Get.parameters.containsKey('cId') ? int.parse(Get.parameters['cId']!) : -1;
      return CategoryScreen(categoryId: categoryId);
    }),
    GetPage(name: _product, page: () {
      int productId = Get.parameters.containsKey('pId') ? int.parse(Get.parameters['pId']!) : -1;
      return ProductScreen(productId: productId);
    }),
    GetPage(name: _cart, page: () => const CartScreen()),
  ];
}