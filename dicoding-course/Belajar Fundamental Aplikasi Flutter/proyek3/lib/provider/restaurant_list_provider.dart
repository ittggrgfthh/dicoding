import 'package:flutter/material.dart';
import 'package:proyek3/data/api/restaurant_list_service.dart';
import 'package:proyek3/data/model/restaurant_list.dart';
import 'package:proyek3/provider/result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final RestaurantListService restaurantListService;

  RestaurantListProvider({required this.restaurantListService}) {
    _fetchAllArticle();
  }

  late RestaurantListModel _restaurantListResult;
  late ResultState _state;
  String _message = "";

  String get message => _message;

  RestaurantListModel get result => _restaurantListResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await restaurantListService.restaurantList();

      if (restaurantList.restaurantList.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantListResult = restaurantList;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error ----> $e";
    }
  }
}
