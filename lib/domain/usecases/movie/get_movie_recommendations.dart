import 'package:dartz/dartz.dart';
import 'package:showtime_getx/domain/entities/movie/movie.dart';
import 'package:showtime_getx/domain/repositories/movie_repository.dart';
import 'package:showtime_getx/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
