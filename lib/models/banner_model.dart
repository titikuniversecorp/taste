import 'dart:convert';

import 'product_model.dart';
import '../utils/string_to_hex.dart';


class BannerModel {
    final int id;
    final String label;
    final String? description;
    final String? backgroundImageUrl;
    final int? backgroundColor;
    final ProductModel? linkedProduct;

    BannerModel({
        required this.id,
        required this.label,
        this.description,
        this.backgroundImageUrl,
        this.backgroundColor,
        this.linkedProduct,
    });

    factory BannerModel.foodCategoryFromJson(String str) => BannerModel.fromJson(json.decode(str));
    static List<BannerModel> foodCategoriesFromJson(String str) => List<BannerModel>.from(json.decode(str).map((x) => BannerModel.fromJson(x)));

    String foodCategoryToJson() => json.encode(toJson());
    String foodCategoriesToJson(List<BannerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

    factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        label: json["name"],
        description: json["description"],
        backgroundImageUrl: json["backgroundImageUrl"],
        backgroundColor: StringToHex.toColor(json["backgroundColor"]),
        linkedProduct: json["linkedProduct"] == null ? null : ProductModel.fromJson(json["linkedProduct"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": label,
        "description": description,
        "backgroundImageUrl": backgroundImageUrl,
        "backgroundColor": backgroundColor.toString(),
        "linkedProduct": linkedProduct?.toJson()
    };
}
