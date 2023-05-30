import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_provider/domain/entities/tv_series/tv_series_detail.dart';
import 'package:showtime_provider/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:showtime_provider/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:showtime_provider/domain/usecases/tv_series/get_watchlist_status.dart';
import 'package:showtime_provider/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:showtime_provider/domain/usecases/tv_series/save_watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvDetail;
  final GetTvSeriesRecommendations getTvRecommendations;
  final GetWatchListStatusTvSeries getWatchListStatusTv;
  final SaveWatchlistTvSeries saveWatchlistTv;
  final RemoveWatchlistTvSeries removeWatchlistTv;

  TvSeriesDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatusTv,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  });

  late TvSeriesDetail _tv;
  TvSeriesDetail get tv => _tv;

  RequestState _tvState = RequestState.empty;
  RequestState get tvState => _tvState;

  List<TvSeries> _tvRecommendations = [];
  List<TvSeries> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationTvState = RequestState.empty;
  RequestState get recommendationTvState => _recommendationTvState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistTv = false;
  bool get isAddedToWatchlistTv => _isAddedtoWatchlistTv;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationTvState = RequestState.loading;
        _tv = tv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationTvState = RequestState.error;
            _message = failure.message;
          },
          (tv) {
            _recommendationTvState = RequestState.success;
            _tvRecommendations = tv;
          },
        );
        _tvState = RequestState.success;
        notifyListeners();
      },
    );
  }

  String _watchlistMessageTv = '';
  String get watchlistMessageTv => _watchlistMessageTv;

  Future<void> addWatchlistTv(TvSeriesDetail tv) async {
    final result = await saveWatchlistTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessageTv = failure.message;
      },
      (successMessage) async {
        _watchlistMessageTv = successMessage;
      },
    );

    await loadWatchlistStatusTv(tv.id);
  }

  Future<void> removeFromWatchlistTv(TvSeriesDetail tv) async {
    final result = await removeWatchlistTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessageTv = failure.message;
      },
      (successMessage) async {
        _watchlistMessageTv = successMessage;
      },
    );

    await loadWatchlistStatusTv(tv.id);
  }

  Future<void> loadWatchlistStatusTv(int id) async {
    final result = await getWatchListStatusTv.execute(id);
    _isAddedtoWatchlistTv = result;
    notifyListeners();
  }
}
