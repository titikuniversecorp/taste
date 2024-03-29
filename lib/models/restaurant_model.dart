import 'dart:convert';

import 'package:taste/models/product_category.dart';

import 'banner_model.dart';
import 'user_address_model.dart';

class RestaurantModel {
  final int id;
  final String name;
  final List<Duration>? waitTime;
  final int? distanse;
  final String? label;
  final double? score;
  final String? logoUrl;
  final String? description;
  final String currency;
  final AddressModel address;
  final List<ProductCategoryModel>? categories;
  final List<BannerModel>? banners;

  RestaurantModel({
    required this.id,
    required this.name,
    this.waitTime,
    this.distanse,
    this.label,
    this.score,
    this.logoUrl,
    this.description,
    required this.address,
    required this.currency,
    this.categories,
    this.banners
  });

  factory RestaurantModel.restaurantFromJson(String str) => RestaurantModel.fromJson(json.decode(str));
  static List<RestaurantModel> restaurantsFromJson(String str) => List<RestaurantModel>.from(json.decode(str).map((x) => RestaurantModel.fromJson(x)));

  String restaurantToJson() => json.encode(toJson());
  static String restaurantsToJson(List<RestaurantModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
    id: json["id"],
    name: json["name"],
    waitTime: json["waitTime"] == null ? [] : List<Duration>.from(json["waitTime"]!.map((x) => Duration(seconds: x))),
    distanse: json["distanse"],
    label: json["label"],
    score: json["score"],
    logoUrl: json["logoUrl"],
    description: json["description"],
    currency: json["currency"],
    address: AddressModel.fromJson(json["address"]),
    categories: json["foodCategories"] == null ? [] : List<ProductCategoryModel>.from(json["foodCategories"]!.map((x) => ProductCategoryModel.fromJson(x))),
    banners: json["banners"] == null ? [] : List<BannerModel>.from(json["banners"]!.map((x) => BannerModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "waitTime": waitTime == null ? [] : List<dynamic>.from(waitTime!.map((x) => x.inSeconds)),
    "distanse": distanse,
    "label": label,
    "score": score,
    "logoUrl": logoUrl,
    "description": description,
    "currency": currency,
    "address": address.toJson(),
    "foodCategories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x.toJson())),
  };
}
