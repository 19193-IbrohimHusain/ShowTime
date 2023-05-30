import 'package:showtime_getx/common/state_enum.dart';
import 'package:showtime_getx/domain/entities/movie/movie.dart';
import 'package:showtime_getx/domain/usecases/movie/search_movies.dart';
import 'package:get/get.dart';

class MovieSearchController extends GetxController {
  final SearchMovies searchMovies;

  MovieSearchController(this.searchMovies);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  final _searchResult = <Movie>[].obs;
  List<Movie> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.loading;
    update();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        update();
      },
      (data) {
        _searchResult.value = data;
        _state = RequestState.success;
        update();
      },
    );
  }

  @override
  void onInit() {
    fetchMovieSearch('');
    super.onInit();
  }
}
