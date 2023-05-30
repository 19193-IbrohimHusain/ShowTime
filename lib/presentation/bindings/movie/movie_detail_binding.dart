import 'package:showtime_getx/domain/repositories/movie_repository.dart';
import 'package:showtime_getx/domain/usecases/movie/get_movie_detail.dart';
import 'package:showtime_getx/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:showtime_getx/domain/usecases/movie/get_watchlist_status.dart';
import 'package:showtime_getx/domain/usecases/movie/remove_watchlist.dart';
import 'package:showtime_getx/domain/usecases/movie/save_watchlist.dart';
import 'package:showtime_getx/presentation/controller/movie/movie_detail_controller.dart';
import 'package:get/get.dart';

class MovieDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MovieDetailController(
        Get.find<GetMovieDetail>(),
        Get.find<GetMovieRecommendations>(),
        Get.find<GetWatchListStatus>(),
        Get.find<SaveWatchlist>(),
        Get.find<RemoveWatchlist>(),
      ),
    );

    Get.lazyPut(() => GetMovieDetail(Get.find<MovieRepository>()));
    Get.lazyPut(() => GetMovieRecommendations(Get.find<MovieRepository>()));
    Get.lazyPut(() => GetWatchListStatus(Get.find<MovieRepository>()));
    Get.lazyPut(() => SaveWatchlist(Get.find<MovieRepository>()));
    Get.lazyPut(() => RemoveWatchlist(Get.find<MovieRepository>()));
  }
}
