import 'package:showtime_getx/domain/repositories/movie_repository.dart';
import 'package:showtime_getx/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:showtime_getx/presentation/controller/movie/watchlist_movie_controller.dart';
import 'package:get/get.dart';

class WatchlistMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => WatchlistMovieController(Get.find<GetWatchlistMovies>()),
    );

    Get.lazyPut(() => GetWatchlistMovies(Get.find<MovieRepository>()));
  }
}
