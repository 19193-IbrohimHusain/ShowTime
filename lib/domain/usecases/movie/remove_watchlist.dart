import 'package:dartz/dartz.dart';
import 'package:showtime_getx/common/failure.dart';
import 'package:showtime_getx/domain/entities/movie/movie_detail.dart';
import 'package:showtime_getx/domain/repositories/movie_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
