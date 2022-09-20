import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyek3/data/model/search.dart';

class SearchService {
  static const String _baseUrl =
      'https://restaurant-api.dicoding.dev/search?q=';

  Future<SearchModel> searchQuery(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + query));

    if (response.statusCode == 200) {
      return SearchModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }
}
