import 'package:showtime_getx/common/state_enum.dart';
import 'package:showtime_getx/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_getx/domain/entities/tv_series/tv_series_detail.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_watchlist_status.dart';
import 'package:showtime_getx/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:showtime_getx/domain/usecases/tv_series/save_watchlist.dart';
import 'package:showtime_getx/presentation/controller/tv_series/watchlist_tv_series_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TvSeriesDetailController extends GetxController
    with StateMixin<TvSeriesDetail> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail _getTvSeriesDetail;
  final GetTvSeriesRecommendations _getTvSeriesRecommendations;
  final GetWatchListStatusTvSeries _getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries _saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries _removeWatchlistTvSeries;

  TvSeriesDetailController(
    this._getTvSeriesDetail,
    this._getTvSeriesRecommendations,
    this._getWatchListStatusTvSeries,
    this._saveWatchlistTvSeries,
    this._removeWatchlistTvSeries,
  );

  late TvSeriesDetail _tvSeriesDetail;
  TvSeriesDetail get tvSeriesDetail => _tvSeriesDetail;

  RequestState _tvSeriesState = RequestState.empty;
  RequestState get tvSeriesState => _tvSeriesState;

  final _tvSeriesRecommendations = <TvSeries>[].obs;
  RxList<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.loading;
    final detailResult = await _getTvSeriesDetail.execute(id);
    final recommendationResult = await _getTvSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.error;
        _message = failure.message;
        change(null, status: RxStatus.error());
      },
      (tvSeries) {
        _recommendationState = RequestState.loading;
        _tvSeriesDetail = tvSeries;
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
            change(null, status: RxStatus.error());
          },
          (recommendation) {
            _recommendationState = RequestState.success;
            _tvSeriesRecommendations.value = recommendation;
            update();
          },
        );
        _tvSeriesState = RequestState.success;
        change(tvSeries, status: RxStatus.success());
      },
    );
  }

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlistTvSeries(TvSeriesDetail tvSeries) async {
    WatchlistTvSeriesController controller = Get.find();
    final result = await _saveWatchlistTvSeries.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
        _isAddedtoWatchlist = true;
        Get.showSnackbar(
          const GetSnackBar(
            messageText: Text(
              watchlistAddSuccessMessage,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            snackStyle: SnackStyle.FLOATING,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );

    await loadWatchlistStatusTvSeries(tvSeries.id);
    await controller.fetchWatchlistTvSeries();
  }

  Future<void> removeFromWatchlistTvSeries(TvSeriesDetail tvSeries) async {
    WatchlistTvSeriesController controller = Get.find();
    final result = await _removeWatchlistTvSeries.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
        _isAddedtoWatchlist = false;
        Get.showSnackbar(
          const GetSnackBar(
            messageText: Text(
              watchlistRemoveSuccessMessage,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white70,
            snackPosition: SnackPosition.BOTTOM,
            snackStyle: SnackStyle.FLOATING,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );

    await loadWatchlistStatusTvSeries(tvSeries.id);
    await controller.fetchWatchlistTvSeries();
  }

  Future<void> loadWatchlistStatusTvSeries(int id) async {
    final result = await _getWatchListStatusTvSeries.execute(id);
    _isAddedtoWatchlist = result;
    update();
  }

  @override
  void onInit() {
    fetchTvSeriesDetail(Get.arguments);
    loadWatchlistStatusTvSeries(Get.arguments);
    super.onInit();
  }
}
