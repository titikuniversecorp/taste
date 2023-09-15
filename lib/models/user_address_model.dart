
import 'dart:convert';

class UserAddressModel {
  final int id;
  final String city;
  final String street;
  final String house;
  final String? entry;
  final String? apartment;
  final String? floor;
  final String? intercom;

  UserAddressModel({
    required this.id,
    required this.city,
    required this.street,
    required this.house,
    this.entry,
    this.apartment,
    this.floor,
    this.intercom
  });

  factory UserAddressModel.userAddressFromJson(String str) => UserAddressModel.fromJson(json.decode(str));
  static List<UserAddressModel> userAddressesFromJson(String str) => List<UserAddressModel>.from(json.decode(str).map((x) => UserAddressModel.fromJson(x)));

  String userAddressToJson() => json.encode(toJson());
  static String userAddressesToJson(List<UserAddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  String get shortAddressAsString {
    String address = "$street, $house";
    return address;
  }

  factory UserAddressModel.fromJson(Map<String, dynamic> json) => UserAddressModel(
    id: json["id"],
    city: json["city"],
    street: json["street"],
    house: json["house"],
    entry: json["entry"],
    apartment: json["apartment"],
    floor: json["floor"],
    intercom: json["intercom"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "street": street,
    "house": house,
    "entry": entry,
    "apartment": apartment,
    "floor": floor,
    "intercom": intercom,
  };
}