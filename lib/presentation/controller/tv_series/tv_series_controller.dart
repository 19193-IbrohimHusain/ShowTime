import 'package:showtime_getx/common/state_enum.dart';
import 'package:showtime_getx/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:get/get.dart';

class TvSeriesController extends GetxController
    with StateMixin<List<TvSeries>> {
  final GetNowPlayingTvSeries _getNowPlayingTvSeries;
  final GetPopularTvSeries _getPopularTvSeries;
  final GetTopRatedTvSeries _getTopRatedTvSeries;

  TvSeriesController(
    this._getNowPlayingTvSeries,
    this._getPopularTvSeries,
    this._getTopRatedTvSeries,
  );

  String _message = '';
  String get message => _message;

  final _nowPlayingTvSeries = <TvSeries>[].obs;
  List<TvSeries> get nowPlayingTvSeries => _nowPlayingTvSeries;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  Future fetchNowPlayingTvSeries() async {
    _nowPlayingState = RequestState.loading;
    final result = await _getNowPlayingTvSeries.execute();
    result.fold((failure) {
      _nowPlayingState = RequestState.error;
      _message = failure.message;
      change(null, status: RxStatus.error(_message));
    }, (moviesData) {
      _nowPlayingState = RequestState.success;
      _nowPlayingTvSeries.value = moviesData;
      change(moviesData, status: RxStatus.success());
    });
  }

  final _popularTvSeries = <TvSeries>[].obs;
  List<TvSeries> get popularTvSeries => _popularTvSeries;

  RequestState _popularTvSeriesState = RequestState.empty;
  RequestState get popularSeriesState => _popularTvSeriesState;

  Future<void> fetchPopularTvSeries() async {
    _popularTvSeriesState = RequestState.loading;
    final result = await _getPopularTvSeries.execute();
    result.fold((failure) {
      _popularTvSeriesState = RequestState.error;
      _message = failure.message;
    }, (moviesData) {
      _popularTvSeriesState = RequestState.success;
      _popularTvSeries.value = moviesData;
    });
  }

  final _topRatedTvSeries = <TvSeries>[].obs;
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;

  RequestState _topRatedTvSeriesState = RequestState.empty;
  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedTvSeriesState = RequestState.loading;
    final result = await _getTopRatedTvSeries.execute();
    result.fold((failure) {
      _topRatedTvSeriesState = RequestState.error;
      _message = failure.message;
    }, (moviesData) {
      _topRatedTvSeriesState = RequestState.success;
      _topRatedTvSeries.value = moviesData;
    });
  }

  @override
  void onInit() {
    fetchNowPlayingTvSeries();
    fetchPopularTvSeries();
    fetchTopRatedTvSeries();
    super.onInit();
  }
}
