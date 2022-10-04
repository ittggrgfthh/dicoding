import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_airing_today.dart';
import 'package:flutter/material.dart';

class TVListNotifier extends ChangeNotifier {
  var _tvAiringToday = <TV>[];
  List<TV> get tvAiringToday => _tvAiringToday;

  RequestState _tvAiringTodayState = RequestState.Empty;
  RequestState get tvAiringTodayState => _tvAiringTodayState;

  var _popularTV = <TV>[];
  List<TV> get popularTV => _popularTV;

  RequestState _popularTVState = RequestState.Empty;
  RequestState get popularTVState => _popularTVState;

  var _topRatedTV = <TV>[];
  List<TV> get topRatedTV => _topRatedTV;

  RequestState _topRatedTVState = RequestState.Empty;
  RequestState get topRatedTVState => _topRatedTVState;

  String _message = '';
  String get message => _message;

  TVListNotifier({
    required this.getTVAiringToday,
    required this.getPopularTV,
    required this.getTopRatedTV,
  });

  final GetTVAiringToday getTVAiringToday;
  final GetPopularTV getPopularTV;
  final GetTopRatedTV getTopRatedTV;

  Future<void> fetchTVAiringToday() async {
    _tvAiringTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getTVAiringToday.execute();
    result.fold(
      (failure) {
        _tvAiringTodayState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _tvAiringTodayState = RequestState.Loaded;
        _tvAiringToday = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTV() async {
    _popularTVState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTV.execute();
    result.fold(
      (failure) {
        _popularTVState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTVState = RequestState.Loaded;
        _popularTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTV() async {
    _topRatedTVState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTV.execute();
    result.fold(
      (failure) {
        _topRatedTVState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTVState = RequestState.Loaded;
        _topRatedTV = tvData;
        notifyListeners();
      },
    );
  }
}
