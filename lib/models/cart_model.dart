import 'dart:convert';

import 'package:taste/models/product_model.dart';

List<CartModel> cartModelFromJson(String str) => List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
    ProductModel product;
    int quantity;
    bool isExist;

    CartModel({
        required this.product,
        required this.quantity,
        required this.isExist,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        product: ProductModel.fromJson(json["product"]),
        quantity: json["quantity"],
        isExist: json["isExit"],
    );

    Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
        "isExit": isExist,
    };
}