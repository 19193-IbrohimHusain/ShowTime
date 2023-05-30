import 'package:showtime_getx/domain/repositories/movie_repository.dart';
import 'package:showtime_getx/domain/usecases/movie/search_movies.dart';
import 'package:showtime_getx/presentation/controller/movie/movie_search_controller.dart';
import 'package:get/get.dart';

class MovieSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MovieSearchController(Get.find<SearchMovies>()),
    );

    Get.lazyPut(() => SearchMovies(Get.find<MovieRepository>()));
  }
}
