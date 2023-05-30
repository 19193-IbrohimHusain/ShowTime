import 'package:showtime_getx/domain/repositories/tv_series_repository.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:showtime_getx/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:showtime_getx/presentation/controller/tv_series/tv_series_controller.dart';
import 'package:get/get.dart';

class TvSeriesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TvSeriesController(
        Get.find<GetNowPlayingTvSeries>(),
        Get.find<GetPopularTvSeries>(),
        Get.find<GetTopRatedTvSeries>(),
      ),
    );

    Get.lazyPut(
      () => GetNowPlayingTvSeries(
        Get.find<TvSeriesRepository>(),
      ),
    );
    Get.lazyPut(
      () => GetPopularTvSeries(
        Get.find<TvSeriesRepository>(),
      ),
    );
    Get.lazyPut(
      () => GetTopRatedTvSeries(
        Get.find<TvSeriesRepository>(),
      ),
    );
  }
}
