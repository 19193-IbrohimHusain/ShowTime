import 'package:showtime_getx/common/state_enum.dart';
import 'package:showtime_getx/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:get/get.dart';

class WatchlistTvSeriesController extends GetxController
    with StateMixin<List<TvSeries>> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesController(this.getWatchlistTvSeries);

  final _watchlistTvSeries = <TvSeries>[].obs;
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistState = RequestState.loading;

    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        change(null, status: RxStatus.error(_message));
      },
      (tvSeriesData) {
        _watchlistState = RequestState.success;
        _watchlistTvSeries.value = tvSeriesData;
        change(_watchlistTvSeries, status: RxStatus.success());
      },
    );
  }

  @override
  void onInit() {
    fetchWatchlistTvSeries();
    super.onInit();
  }
}
