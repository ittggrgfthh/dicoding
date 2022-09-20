import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyek3/data/model/restaurant_list.dart';

class RestaurantListService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/list';

  Future<RestaurantListModel> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      return RestaurantListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }
}
