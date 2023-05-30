import 'package:dartz/dartz.dart';
import 'package:showtime_provider/common/failure.dart';
import 'package:showtime_provider/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_provider/domain/repositories/tv_series_repository.dart';

class GetNowPlaying {
  final TvSeriesRepository repository;

  GetNowPlaying(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getNowPlaying();
  }
}
