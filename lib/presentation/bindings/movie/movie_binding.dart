import 'package:showtime_getx/domain/repositories/movie_repository.dart';
import 'package:showtime_getx/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:showtime_getx/domain/usecases/movie/get_popular_movies.dart';
import 'package:showtime_getx/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:showtime_getx/presentation/controller/movie/movie_controller.dart';
import 'package:get/get.dart';

class MovieBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MovieController(
        Get.find<GetNowPlayingMovies>(),
        Get.find<GetPopularMovies>(),
        Get.find<GetTopRatedMovies>(),
      ),
    );

    Get.lazyPut(() => GetNowPlayingMovies(Get.find<MovieRepository>()));
    Get.lazyPut(() => GetPopularMovies(Get.find<MovieRepository>()));
    Get.lazyPut(() => GetTopRatedMovies(Get.find<MovieRepository>()));
  }
}
