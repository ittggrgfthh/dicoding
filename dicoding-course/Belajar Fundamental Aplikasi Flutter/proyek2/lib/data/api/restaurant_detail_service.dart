import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyek2/data/model/restaurant_detail.dart';

class RestaurantDetailService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/detail/';

  Future<RestaurantDetailModel> restaurantDetail(String detailId) async {
    final response = await http.get(Uri.parse(_baseUrl + detailId));

    if (response.statusCode == 200) {
      return RestaurantDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }
}
