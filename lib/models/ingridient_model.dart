import 'dart:convert';


class IngridientModel {
    final int id;
    final String name;
    final String imageUrl;

    IngridientModel({
        required this.id,
        required this.name,
        required this.imageUrl,
    });

    factory IngridientModel.ingridientFromJson(String str) => IngridientModel.fromJson(json.decode(str));
    static List<IngridientModel> ingridientModelFromJson(String str) => List<IngridientModel>.from(json.decode(str).map((x) => IngridientModel.fromJson(x)));

    String ingridientToJson() => json.encode(toJson());
    String ingridientsToJson(List<IngridientModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

    factory IngridientModel.fromJson(Map<String, dynamic> json) => IngridientModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
    };
}
