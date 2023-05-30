import 'package:dartz/dartz.dart';
import 'package:showtime_getx/domain/entities/movie/movie.dart';
import 'package:showtime_getx/domain/repositories/movie_repository.dart';
import 'package:showtime_getx/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
