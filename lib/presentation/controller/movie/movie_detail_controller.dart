import 'package:showtime_getx/common/state_enum.dart';
import 'package:showtime_getx/domain/entities/movie/movie.dart';
import 'package:showtime_getx/domain/entities/movie/movie_detail.dart';
import 'package:showtime_getx/domain/usecases/movie/get_movie_detail.dart';
import 'package:showtime_getx/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:showtime_getx/domain/usecases/movie/get_watchlist_status.dart';
import 'package:showtime_getx/domain/usecases/movie/remove_watchlist.dart';
import 'package:showtime_getx/domain/usecases/movie/save_watchlist.dart';
import 'package:showtime_getx/presentation/controller/movie/watchlist_movie_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailController extends GetxController
    with StateMixin<MovieDetail> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieDetailController(
    this._getMovieDetail,
    this._getMovieRecommendations,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  );

  late MovieDetail _movieDetail;
  MovieDetail get movieDetail => _movieDetail;

  RequestState _movieState = RequestState.empty;
  RequestState get movieState => _movieState;

  final _movieRecommendations = <Movie>[].obs;
  RxList<Movie> get movieRecommendations => _movieRecommendations;

  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.loading;
    final detailResult = await _getMovieDetail.execute(id);
    final recommendationResult = await _getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = RequestState.error;
        _message = failure.message;
        change(null, status: RxStatus.error());
      },
      (movie) {
        _recommendationState = RequestState.loading;
        movie;
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
            change(null, status: RxStatus.error());
          },
          (movies) {
            _recommendationState = RequestState.success;
            _movieRecommendations.value = movies;
            update();
          },
        );
        _movieState = RequestState.success;
        change(movie, status: RxStatus.success());
      },
    );
  }

  late bool _isAddedtoWatchlist;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(MovieDetail movieDetail) async {
    WatchlistMovieController controller = Get.find();
    final result = await _saveWatchlist.execute(movieDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
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

    await loadWatchlistStatus(movieDetail.id);
    await controller.fetchWatchlistMovies();
  }

  Future<void> removeFromWatchlist(MovieDetail movieDetail) async {
    WatchlistMovieController controller = Get.find();
    final result = await _removeWatchlist.execute(movieDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
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

    await loadWatchlistStatus(movieDetail.id);
    await controller.fetchWatchlistMovies();
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await _getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    update();
  }

  @override
  void onInit() {
    fetchMovieDetail(Get.arguments);
    loadWatchlistStatus(Get.arguments);
    super.onInit();
  }
}
