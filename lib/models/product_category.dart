import 'dart:convert';

import 'product_model.dart';
import '../utils/string_to_hex.dart';


class ProductCategoryModel {
    final int id;
    final String name;
    final String? backgroundImageUrl;
    final int? backgroundColor;
    final List<ProductModel> products;

    ProductCategoryModel({
        required this.id,
        required this.name,
        this.backgroundImageUrl,
        this.backgroundColor,
        required this.products,
    });

    factory ProductCategoryModel.foodCategoryFromJson(String str) => ProductCategoryModel.fromJson(json.decode(str));
    static List<ProductCategoryModel> foodCategoriesFromJson(String str) => List<ProductCategoryModel>.from(json.decode(str).map((x) => ProductCategoryModel.fromJson(x)));

    String foodCategoryToJson() => json.encode(toJson());
    String foodCategoriesToJson(List<ProductCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

    factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => ProductCategoryModel(
        id: json["id"],
        name: json["name"],
        backgroundImageUrl: json["backgroundImage"],
        backgroundColor: StringToHex.toColor(json["backgroundColor"]),
        products: List<ProductModel>.from(json["foods"]!.map((x) => ProductModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "backgroundImage": backgroundImageUrl,
        "backgroundColor": backgroundColor.toString(),
        "foods": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}
