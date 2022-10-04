import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_airing_today.dart';
import 'package:flutter/foundation.dart';

class TVAiringTodayNotifier extends ChangeNotifier {
  final GetTVAiringToday getTVAiringToday;

  TVAiringTodayNotifier(this.getTVAiringToday);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _tv = [];
  List<TV> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVAiringToday() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTVAiringToday.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
