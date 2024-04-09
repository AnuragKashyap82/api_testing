import 'package:api_test/Controller/food_controller.dart';
import 'package:api_test/widgets/food_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ScrollController _controller = ScrollController();
  FoodController foodController = Get.put(FoodController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(_scrollListener);
  }
  int currentPage = 1; // Variable to track the current page
  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      currentPage++; // Increment the page number
      foodController.fetchMoreFood(currentPage.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: Color(0xffEEEEEE),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: PhysicalModel(
                color: Colors.white,
                elevation: 7,
                shadowColor: Colors.transparent,
                child: Container(
                  height: 43,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/search.png"),
                        SizedBox(
                          width: 32,
                        ),
                        Expanded(child: Text("Name ur mood....")),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: VerticalDivider(width: 1, color: Colors.black, thickness: 1,),

                        ),

                        SizedBox(width: 16,),
                        Image.asset("assets/images/Vector.png"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              child: Obx(() {
                if (foodController.isLoading.value) {
                  return   Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: double.infinity,
                      child: Center(child: Lottie.asset(
                        'assets/raw/loading.json',
                        width: 200,
                        height: 200,
                      )),
                    )
                  );
                }
                if (foodController.allFoods.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Foods",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: foodController.allFoods.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final food = foodController.allFoods[index];
                    return FoodCards(foodItem: food);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
