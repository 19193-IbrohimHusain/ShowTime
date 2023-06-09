import 'package:dartz/dartz.dart';
import 'package:showtime_provider/domain/entities/movie/movie_detail.dart';
import 'package:showtime_provider/domain/repositories/movie_repository.dart';
import 'package:showtime_provider/common/failure.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
