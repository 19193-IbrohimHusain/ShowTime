import 'package:dartz/dartz.dart';
import 'package:showtime_getx/common/failure.dart';
import 'package:showtime_getx/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_getx/domain/repositories/tv_series_repository.dart';

class GetNowPlayingTvSeries {
  final TvSeriesRepository repository;

  GetNowPlayingTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getNowPlayingTvSeries();
  }
}