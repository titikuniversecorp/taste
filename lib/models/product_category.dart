import 'dart:convert';

import 'product_model.dart';
import '../utils/string_to_hex.dart';


class ProductCategoryModel {
    final int id;
    final String name;
    final String? backgroundImage;
    final int? backgroundColor;
    final List<ProductModel> foods;

    ProductCategoryModel({
        required this.id,
        required this.name,
        this.backgroundImage,
        this.backgroundColor,
        required this.foods,
    });

    factory ProductCategoryModel.foodCategoryFromJson(String str) => ProductCategoryModel.fromJson(json.decode(str));
    static List<ProductCategoryModel> foodCategoriesFromJson(String str) => List<ProductCategoryModel>.from(json.decode(str).map((x) => ProductCategoryModel.fromJson(x)));

    String foodCategoryToJson() => json.encode(toJson());
    String foodCategoriesToJson(List<ProductCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

    factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => ProductCategoryModel(
        id: json["id"],
        name: json["name"],
        backgroundImage: json["backgroundImage"],
        backgroundColor: StringToHex.toColor(json["backgroundColor"]),
        foods: List<ProductModel>.from(json["foods"]!.map((x) => ProductModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "backgroundImage": backgroundImage,
        "backgroundColor": backgroundColor.toString(),
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    };
}
