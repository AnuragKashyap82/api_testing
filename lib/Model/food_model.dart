class FoodItem {
  String id;
  String name;
  String photo;
  String restaurant;
  String description;
  List<Serving> servings;
  List<String> tags;

  FoodItem({
    required this.id,
    required this.name,
    required this.photo,
    required this.restaurant,
    required this.description,
    required this.servings,
    required this.tags,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    List<dynamic> servingsList = json['servings'];
    List<Serving> servings = servingsList.map((servingJson) => Serving.fromJson(servingJson)).toList();

    List<dynamic> tagsList = json['tags'];
    List<String> tags = tagsList.cast<String>();

    return FoodItem(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
      restaurant: json['restaurant'] ?? '',
      description: json['description'] ?? '',
      servings: servings,
      tags: tags,
    );
  }
}

class Serving {
  String size;
  int price;
  String description;
  String id;

  Serving({
    required this.size,
    required this.price,
    required this.description,
    required this.id,
  });

  factory Serving.fromJson(Map<String, dynamic> json) {
    return Serving(
      size: json['size'] ?? '',
      price: json['price'] ?? 0,
      description: json['desc'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}
