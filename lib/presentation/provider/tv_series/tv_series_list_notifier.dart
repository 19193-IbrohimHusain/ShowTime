import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_provider/domain/usecases/tv_series/get_now_playing.dart';
import 'package:showtime_provider/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:showtime_provider/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTv = <TvSeries>[];
  List<TvSeries> get nowPlayingTv => _nowPlayingTv;

  RequestState _nowPlayingTvState = RequestState.empty;
  RequestState get nowPlayingTvState => _nowPlayingTvState;

  var _popularTv = <TvSeries>[];
  List<TvSeries> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <TvSeries>[];
  List<TvSeries> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.empty;
  RequestState get topRatedTvState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  });

  final GetNowPlaying getNowPlayingTv;
  final GetPopularTvSeries getPopularTv;
  final GetTopRatedTvSeries getTopRatedTv;

  Future<void> fetchNowPlayingTv() async {
    _nowPlayingTvState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();
    result.fold(
      (failure) {
        _nowPlayingTvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _nowPlayingTvState = RequestState.success;
        _nowPlayingTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvState = RequestState.success;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _topRatedTvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTvState = RequestState.success;
        _topRatedTv = tvData;
        notifyListeners();
      },
    );
  }
}
