import 'package:showtime_getx/domain/repositories/tv_series_repository.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_watchlist_status.dart';
import 'package:showtime_getx/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:showtime_getx/domain/usecases/tv_series/save_watchlist.dart';
import 'package:showtime_getx/presentation/controller/tv_series/tv_series_detail_controller.dart';
import 'package:get/get.dart';

class TvSeriesDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TvSeriesDetailController(
        Get.find<GetTvSeriesDetail>(),
        Get.find<GetTvSeriesRecommendations>(),
        Get.find<GetWatchListStatusTvSeries>(),
        Get.find<SaveWatchlistTvSeries>(),
        Get.find<RemoveWatchlistTvSeries>(),
      ),
    );

    Get.lazyPut(() => GetTvSeriesDetail(Get.find<TvSeriesRepository>()));
    Get.lazyPut(
        () => GetTvSeriesRecommendations(Get.find<TvSeriesRepository>()));
    Get.lazyPut(
        () => GetWatchListStatusTvSeries(Get.find<TvSeriesRepository>()));
    Get.lazyPut(() => SaveWatchlistTvSeries(Get.find<TvSeriesRepository>()));
    Get.lazyPut(() => RemoveWatchlistTvSeries(Get.find<TvSeriesRepository>()));
  }
}
