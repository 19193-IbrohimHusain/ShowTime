import 'package:dartz/dartz.dart';
import 'package:showtime_provider/common/failure.dart';
import 'package:showtime_provider/domain/entities/movie/movie.dart';
import 'package:showtime_provider/domain/repositories/movie_repository.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
