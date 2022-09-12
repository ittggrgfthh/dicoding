import 'package:flutter/material.dart';
import 'package:proyek2/data/api/add_review_service.dart';
import 'package:proyek2/data/model/add_review.dart';

enum ResultState { loading, noData, hasData, error }

class AddReviewProvider extends ChangeNotifier {
  final AddReviewService addReviewService;

  AddReviewProvider({required this.addReviewService});

  ResultState _state = ResultState.noData;
  String _message = "";
  AddReviewModel _addReviewModel = AddReviewModel(
    error: false,
    message: "",
    customerReviews: [],
  );

  String _id = "";
  String _name = "";
  String _review = "";

  ResultState get state => _state;
  String get message => _message;
  String get id => _id;
  AddReviewModel get reviewResult => _addReviewModel;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setReview(String review) {
    _review = review;
    notifyListeners();
  }

  submitReview(String id) {
    _id = id;
    if (_name.isNotEmpty && _review.isNotEmpty) {
      _sendReviewToAPI();
    } else {
      _state = ResultState.noData;
      _addReviewModel = AddReviewModel(
        error: false,
        message: "",
        customerReviews: [],
      );
      notifyListeners();
      return _message = "Nama atau Komentar kosong!";
    }
  }

  Future<dynamic> _sendReviewToAPI() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final sendReview = await addReviewService.addReview(_id, _name, _review);
      if (sendReview.customerReviews.isEmpty) {
        _state = ResultState.noData;
        _addReviewModel = AddReviewModel(
          error: false,
          message: "",
          customerReviews: [],
        );
        notifyListeners();
        _message = "Review Kosong";
      } else if (sendReview.customerReviews.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        return _addReviewModel = sendReview;
      }
    } catch (e) {
      _state = ResultState.error;
      _addReviewModel = AddReviewModel(
        error: false,
        message: "",
        customerReviews: [],
      );
      notifyListeners();
      return _message = "Gagal menambahkan komentar";
    }
  }
}
