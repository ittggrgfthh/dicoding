import 'package:flutter/material.dart';
import 'package:proyek3/data/api/restaurant_detail_service.dart';
import 'package:proyek3/data/model/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final RestaurantDetailService restaurantDetailService;

  RestaurantDetailProvider({required this.restaurantDetailService});

  late RestaurantDetailModel _restaurantDetailResult;
  late ResultState _state;
  String _message = "";

  String get message => _message;

  RestaurantDetailModel get result => _restaurantDetailResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await restaurantDetailService.restaurantDetail(id);

      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantDetailResult = restaurantList;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error ----> $e";
    }
  }

  void setRestaurantDetail(RestaurantDetailModel restaurantDetailModel) {
    _restaurantDetailResult = restaurantDetailModel;
    notifyListeners();
    _fetchAllDetailRestaurant(restaurantDetailModel.restaurant.id);
  }
}
