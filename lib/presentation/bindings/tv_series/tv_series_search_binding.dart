import 'package:showtime_getx/domain/repositories/tv_series_repository.dart';
import 'package:showtime_getx/domain/usecases/tv_series/search_tv_series.dart';
import 'package:showtime_getx/presentation/controller/tv_series/tv_series_search_controller.dart';
import 'package:get/get.dart';

class TvSeriesSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TvSeriesSearchController(Get.find<SearchTvSeries>()),
    );

    Get.lazyPut(() => SearchTvSeries(Get.find<TvSeriesRepository>()));
  }
}
