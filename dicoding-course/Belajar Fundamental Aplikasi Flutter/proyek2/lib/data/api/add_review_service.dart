import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyek2/data/model/add_review.dart';

class AddReviewService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _category = 'review';
  static const String _header = 'application/json; charset=UTF-8';

  Future<AddReviewModel> addReview(
    String id,
    String name,
    String review,
  ) async {
    final body =
        jsonEncode(<String, String>{'id': id, 'name': name, 'review': review});
    final response = await http.post(
      Uri.parse(_baseUrl + _category),
      headers: <String, String>{
        "Content-Type": _header,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return AddReviewModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Review $name gagal terkirim');
    }
  }
}
