import 'package:flutter_food_delivery_ui/models/food.dart';

class Restaurant {
  final String imageUrl;
  final String name;
  final String address;
  final int rating;
  final List<Food> menu;

  Restaurant({
    this.imageUrl,
    this.name,
    this.address,
    this.rating,
    this.menu,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        imageUrl: json['imageUrl'],
        name: json['name'],
        address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
        'name': name,
        'address': address,
      };
}
