import 'package:api_test/Model/food_model.dart';
import 'package:api_test/Repo/food_repository.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  static FoodController get instance => Get.find();

  final isLoading = false.obs;
  final _foodsRepository = Get.put(FoodRepository());
  RxList<FoodItem> allFoods = <FoodItem>[].obs;

  @override
  void onInit() {
    fetchFoods();
    super.onInit();
  }

  Future<void> fetchFoods() async {
    try {
      isLoading.value = true;
      final foods = await _foodsRepository.getAllFood("1");
      allFoods.assignAll(foods);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchMoreFood(String page) async {
    try {
      final foods = await _foodsRepository.getAllFood(page);
      allFoods.addAll(foods);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
