import 'dart:convert';
import 'package:flutter/services.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final List<String> foods;
  final List<String> drinks;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'],
        foods: List<String>.from(json['menus']['foods']
            .map((json) => json['name'].toString())
            .toList()),
        drinks: List<String>.from(json['menus']['drinks']
            .map((json) => json['name'].toString())
            .toList()),
      );
}

class RestaurantRepository {
  List<Restaurant> restaurantList = [];

  Future<List<Restaurant>> readJson() async {
    final response = await rootBundle.loadString('assets/restaurants.json');
    final data = await json.decode(response);
    var rList =
        await data['restaurants'].map((data) => Restaurant.fromJson(data));
    restaurantList = List<Restaurant>.from(rList);
    return restaurantList;
  }
}
