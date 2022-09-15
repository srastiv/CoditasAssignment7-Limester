import 'package:meta/meta.dart';
import 'dart:convert';

class FoodNetworkHelper {
  FoodNetworkHelper({
    required this.id,
    required this.foodName,
    required this.foodPrice,
    required this.foodPicture,
    this.quantity = 1,
  });

  final int id;
  final String foodName;
  final int foodPrice;
  final String foodPicture;
  int quantity;

  factory FoodNetworkHelper.fromRawJson(String str) =>
      FoodNetworkHelper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FoodNetworkHelper.fromJson(Map<String, dynamic> json) =>
      FoodNetworkHelper(
        id: json["id"],
        foodName: json["foodName"],
        foodPrice: json["foodPrice"],
        foodPicture: json["foodPicture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "foodName": foodName,
        "foodPrice": foodPrice,
        "foodPicture": foodPicture,
      };
}
