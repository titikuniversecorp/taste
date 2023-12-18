
import 'dart:convert';

class AddressModel {
  final int id;
  final String city;
  final String street;
  final String house;
  final String? entry;
  final String? apartment;
  final String? floor;
  final String? intercom;

  AddressModel({
    required this.id,
    required this.city,
    required this.street,
    required this.house,
    this.entry,
    this.apartment,
    this.floor,
    this.intercom
  });

  factory AddressModel.addressFromJson(String str) => AddressModel.fromJson(json.decode(str));
  static List<AddressModel> addressesFromJson(String str) => List<AddressModel>.from(json.decode(str).map((x) => AddressModel.fromJson(x)));

  String addressToJson() => json.encode(toJson());
  static String addressesToJson(List<AddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  String get shortAddressAsString {
    String address = "$street, $house";
    return address;
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
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