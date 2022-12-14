import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_watchlist.dart';
import 'package:flutter/foundation.dart';

class WatchlistTVNotifier extends ChangeNotifier {
  var _watchlistTV = <TV>[];
  List<TV> get watchlistTV => _watchlistTV;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTVNotifier({required this.getWatchlistTV});

  final GetTVWatchlist getWatchlistTV;

  Future<void> fetchWatchlistTV() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTV.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTV = tvData;
        notifyListeners();
      },
    );
  }
}
