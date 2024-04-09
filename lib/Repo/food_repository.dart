import 'dart:convert';
import 'package:api_test/Model/food_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class FoodRepository extends GetxController {
  static FoodRepository get instance => Get.find();

  Future<List<FoodItem>> getAllFood(String page) async {
    try {
      final response = await http.get(
        Uri.parse('http://195.181.240.146:4444/api/v1/public/search/items?page=${page}&count=10'),
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> foodData = json.decode(response.body)['data'];
        final List<FoodItem> foods = foodData
            .map((bookJson) => FoodItem.fromJson(bookJson))
            .toList();
        print('Response Boosk status code: ${foods}');
        return foods;
      } else {
        throw "Failed to load books: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
