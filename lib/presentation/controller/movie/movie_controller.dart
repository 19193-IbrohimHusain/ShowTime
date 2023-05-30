import 'package:showtime_getx/common/state_enum.dart';
import 'package:showtime_getx/domain/entities/movie/movie.dart';
import 'package:showtime_getx/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:showtime_getx/domain/usecases/movie/get_popular_movies.dart';
import 'package:showtime_getx/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:get/get.dart';

class MovieController extends GetxController with StateMixin<List<Movie>> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  MovieController(
    this._getNowPlayingMovies,
    this._getPopularMovies,
    this._getTopRatedMovies,
  );

  String _message = '';
  String get message => _message;

  final _nowPlayingMovies = <Movie>[].obs;
  RxList<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  Future fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.loading;
    final result = await _getNowPlayingMovies.execute();
    result.fold((failure) {
      _nowPlayingState = RequestState.error;
      _message = failure.message;
      change(null, status: RxStatus.error(_message));
    }, (moviesData) {
      _nowPlayingState = RequestState.success;
      _nowPlayingMovies.value = moviesData;
      change(moviesData, status: RxStatus.success());
    });
  }

  final _popularMovies = <Movie>[].obs;
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.empty;
  RequestState get popularMoviesState => _popularMoviesState;

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = RequestState.loading;
    final result = await _getPopularMovies.execute();
    result.fold((failure) {
      _popularMoviesState = RequestState.error;
      _message = failure.message;
    }, (moviesData) {
      _popularMoviesState = RequestState.success;
      _popularMovies.value = moviesData;
    });
  }

  final _topRatedMovies = <Movie>[].obs;
  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedMoviesState = RequestState.empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = RequestState.loading;
    final result = await _getTopRatedMovies.execute();
    result.fold((failure) {
      _topRatedMoviesState = RequestState.error;
      _message = failure.message;
    }, (moviesData) {
      _topRatedMoviesState = RequestState.success;
      _topRatedMovies.value = moviesData;
    });
  }

  @override
  void onInit() {
    fetchNowPlayingMovies();
    fetchPopularMovies();
    fetchTopRatedMovies();
    super.onInit();
  }
}
