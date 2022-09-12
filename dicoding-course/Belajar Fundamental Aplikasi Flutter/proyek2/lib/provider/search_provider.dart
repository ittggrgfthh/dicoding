import 'package:flutter/material.dart';
import 'package:proyek2/data/api/search_service.dart';
import 'package:proyek2/data/model/search.dart';

enum ResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final SearchService searchService;

  SearchProvider({required this.searchService});

  SearchModel _searchResult = SearchModel(
    error: false,
    founded: 0,
    restaurants: [],
  );
  ResultState _state = ResultState.noData;
  String _message = "";
  String _query = "";

  ResultState get state => _state;
  String get message => _message;
  String get query => _query;
  SearchModel get result => _searchResult;

  void setQuery(String value) {
    _query = value;
    _fetchSearchQuery();
  }

  Future<dynamic> _fetchSearchQuery() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final searchValue = await searchService.searchQuery(_query);

      if (searchValue.restaurants.isEmpty) {
        _state = ResultState.noData;
        _searchResult = SearchModel(
          error: false,
          founded: 0,
          restaurants: [],
        );
        notifyListeners();
        _message = "Restoran tidak ditemukan!";
        return _searchResult = searchValue;
      } else if (searchValue.restaurants.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = searchValue;
      }
    } catch (e) {
      _state = ResultState.error;
      _searchResult = SearchModel(
        error: false,
        founded: 0,
        restaurants: [],
      );
      notifyListeners();
      return _message = "Gagal mendapatkan Daftar Restoran";
    }
  }
}
