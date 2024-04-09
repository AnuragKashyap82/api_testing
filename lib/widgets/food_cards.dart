import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:api_test/Model/food_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FoodCards extends StatefulWidget {
  final FoodItem foodItem;

  const FoodCards({Key? key, required this.foodItem}) : super(key: key);

  @override
  State<FoodCards> createState() => _FoodCardsState();
}

class _FoodCardsState extends State<FoodCards> {
  late Future<Uint8List?> _imageFuture = Future.value(null);
  // Function to fetch image from the API
  Future<Uint8List?> getImage() async {
    try {
      final response = await http.get(Uri.parse("http://195.181.240.146:4444/api/v1/public/image/${widget.foodItem.photo}"));

      print(response.body);

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw "Failed to load image: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.foodItem.photo.isNotEmpty) { // Ensure photoUrl is not empty before initializing _imageFuture
      _imageFuture = getImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Serving? smallServing;
    for (var serving in widget.foodItem.servings) {
      if (serving.size.toLowerCase() == 'small') {
        smallServing = serving;
        break;
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 7,
        borderRadius: BorderRadius.circular(0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0)
                        .copyWith(right: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:
                      FutureBuilder<Uint8List?>(
                        future: _imageFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              width: 100,
                                height: 100,
                                child: Center(child: Lottie.asset(
                                  'assets/raw/loading.json',
                                  width: 200,
                                  height: 200,
                                )));
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.data != null) {
                            return Stack(
                              children: [
                                Image.memory(
                                  snapshot.data!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Color(0xff47B275),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.white, size: 14),
                                          SizedBox(width: 4),
                                          Text("4.6", style: TextStyle(fontSize: 10, color: Colors.white)),
                                          SizedBox(width: 4),
                                          Text("(456)", style: TextStyle(fontSize: 10, color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container(); // Placeholder or fallback widget if image data is not available
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.foodItem.restaurant,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 180),
                          child: Text(
                            widget.foodItem.description,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff757575)),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              smallServing != null
                                  ? 'Start from ${smallServing.price.toString()}rs'
                                  : 'Start from N/A',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff333333)),
                            ),
                            SizedBox(width: 2,),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Container(
                                height: 4,
                                width: 4,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle
                                ),
                              ),
                            ),
                            SizedBox(width: 2,),
                            Text(
                              "4.6Km Distance",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff333333)),
                            ),
                            SizedBox(width: 2,),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Container(
                                height: 4,
                                width: 4,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle
                                ),
                              ),
                            ),
                            SizedBox(width: 2,),
                            Text(
                              "Delivery in 15 min",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff333333)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Color(0xff2F80ED).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("Extra discount", style: TextStyle(fontSize: 10, color: Color(0xff2F80ED)),),
                              )),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Color(0xffFF9213).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("Free delivery", style: TextStyle(fontSize: 10, color: Color(0xff47B275)),),
                              )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
