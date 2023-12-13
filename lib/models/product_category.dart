import 'dart:convert';

import 'product_model.dart';
import '../utils/string_to_hex.dart';

class ProductCategoryModel {
    final int id;
    final String name;
    final String? backgroundImageUrl;
    final int? backgroundColor;
    final List<ProductContainerModel> productContainers;

    ProductCategoryModel({
        required this.id,
        required this.name,
        this.backgroundImageUrl,
        this.backgroundColor,
        required this.productContainers,
    });

    factory ProductCategoryModel.foodCategoryFromJson(String str) => ProductCategoryModel.fromJson(json.decode(str));
    static List<ProductCategoryModel> foodCategoriesFromJson(String str) => List<ProductCategoryModel>.from(json.decode(str).map((x) => ProductCategoryModel.fromJson(x)));

    String foodCategoryToJson() => json.encode(toJson());
    String foodCategoriesToJson(List<ProductCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

    factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => ProductCategoryModel(
        id: json["id"],
        name: json["name"],
        backgroundImageUrl: json["backgroundImageUrl"],
        backgroundColor: StringToHex.toColor(json["backgroundColor"]),
        productContainers: List<ProductContainerModel>.from(json["productContainers"]!.map((x) => ProductContainerModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "backgroundImageUrl": backgroundImageUrl,
        "backgroundColor": backgroundColor.toString(),
        "productContainers": List<dynamic>.from(productContainers.map((x) => x.toJson())),
    };
}

class ProductContainerModel {
  final int id;
  final List<ProductModel> products;

  ProductContainerModel({
    required this.id,
    required this.products
  });

  factory ProductContainerModel.productContainerFromJson(String str) => ProductContainerModel.fromJson(json.decode(str));
    static List<ProductContainerModel> productContainersFromJson(String str) => List<ProductContainerModel>.from(json.decode(str).map((x) => ProductContainerModel.fromJson(x)));

    String productContainerToJson() => json.encode(toJson());
    String productContainersToJson(List<ProductContainerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

    factory ProductContainerModel.fromJson(Map<String, dynamic> json) => ProductContainerModel(
        id: json["id"],
        products: List<ProductModel>.from(json["foods"]!.map((x) => ProductModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "foods": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}