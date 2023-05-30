import 'package:showtime_getx/domain/repositories/tv_series_repository.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:showtime_getx/presentation/controller/tv_series/watchlist_tv_series_controller.dart';
import 'package:get/get.dart';

class WatchlistTvSeriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => WatchlistTvSeriesController(Get.find<GetWatchlistTvSeries>()),
    );

    Get.lazyPut(() => GetWatchlistTvSeries(Get.find<TvSeriesRepository>()));
  }
}
