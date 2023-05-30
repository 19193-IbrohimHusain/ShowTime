import 'package:showtime_getx/common/state_enum.dart';
import 'package:showtime_getx/domain/entities/movie/movie.dart';
import 'package:showtime_getx/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:get/get.dart';

class WatchlistMovieController extends FullLifeCycleController
    with StateMixin<List<Movie>> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieController(this.getWatchlistMovies);

  final _watchlistMovies = <Movie>[].obs;
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.loading;

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        change(null, status: RxStatus.error(_message));
      },
      (moviesData) {
        _watchlistState = RequestState.success;
        _watchlistMovies.value = moviesData;
        change(_watchlistMovies, status: RxStatus.success());
      },
    );
  }

  @override
  void onInit() {
    fetchWatchlistMovies();
    super.onInit();
  }
}
