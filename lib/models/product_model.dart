import 'dart:convert';

import 'package:taste/models/ingridient_model.dart';

class ProductModel {
    final int id;
    final String name;
    final List<Duration>? waitTime;
    final String? imageUrl;
    final List<String>? galleryImages;
    final String? about;
    final String? description;
    final double? score;
    final int calories;
    final double price;
    final int weight;
    final bool highLight;
    final int commentCount;
    final List<IngridientModel>? ingridients;
    /// Надпись варианта блюда (например: маленький, средний или большой)
    final String? variantLabel;

    ProductModel({
        required this.id,
        required this.name,
        this.waitTime,
        this.imageUrl,
        this.galleryImages,
        this.about,
        this.description,
        this.score,
        required this.calories,
        required this.price,
        required this.weight,
        this.highLight = false, 
        this.commentCount = 0,
        this.ingridients,
        this.variantLabel
    });

    factory ProductModel.foodFromJson(String str) => ProductModel.fromJson(json.decode(str));
    static List<ProductModel> foodsFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

    String foodToJson() => json.encode(toJson());
    String foodsToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        waitTime: json["waitTime"] == null ? [] : List<Duration>.from(json["waitTime"]!.map((x) => Duration(seconds: x))),
        imageUrl: json["imageUrl"],
        galleryImages: json["galleryImages"] == null ? [] : List<String>.from(json["galleryImages"]!.map((x) => x)),
        about: json["about"],
        description: json["description"],
        score: json["score"]?.toDouble(),
        calories: json["calories"],
        price: json["price"].toDouble(),
        weight: json["weight"],
        highLight: json["highLight"],
        commentCount: json["commentCount"],
        ingridients: json["ingridients"] == null ? [] : List<IngridientModel>.from(json["ingridients"]!.map((x) => IngridientModel.fromJson(x))),
        variantLabel: json["variantLabel"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "waitTime": waitTime == null ? [] : List<dynamic>.from(waitTime!.map((x) => x.inSeconds)),
        "imageUrl": imageUrl,
        "galleryImages": galleryImages == null ? [] : List<dynamic>.from(galleryImages!.map((x) => x)),
        "about": about,
        "description": description,
        "score": score,
        "calories": calories,
        "price": price,
        "weight": weight,
        "highLight": highLight,
        "commentCount": commentCount,
        "ingridients": ingridients == null ? [] : List<dynamic>.from(ingridients!.map((x) => x.toJson())),
        "variantLabel": variantLabel
    };
}
