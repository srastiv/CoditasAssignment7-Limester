import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'food_network_model.dart';

Future<List<FoodNetworkHelper>> getFoodData() async {
  try {
    var addressIPv4 = "192.168.250.211";

    var response = await http.get(
      Uri.parse("http://127.0.0.1:3000/foods"),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      List jsonData = jsonDecode(data);
      var result = jsonData
          .map(
            (e) => FoodNetworkHelper.fromJson(e),
          )
          .toList();
      debugPrint(result.toString());
      return result;
    } else
      return [];
  } catch (error) {
    print("THERE IS AN ERROR: $error");
  }
  return [];
}
