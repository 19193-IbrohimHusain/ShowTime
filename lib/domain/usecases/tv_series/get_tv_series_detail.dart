import 'package:dartz/dartz.dart';
import 'package:showtime_getx/common/failure.dart';
import 'package:showtime_getx/domain/entities/tv_series/tv_series_detail.dart';
import 'package:showtime_getx/domain/repositories/tv_series_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
