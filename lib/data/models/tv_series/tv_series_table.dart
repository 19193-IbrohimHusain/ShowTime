import 'package:showtime_getx/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_getx/domain/entities/tv_series/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;
  final double voteAverage;
  final int voteCount;

  const TvSeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tv) => TvSeriesTable(
        id: tv.id,
        name: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
        voteAverage: tv.voteAverage,
        voteCount: tv.voteCount,
      );

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        voteAverage: map['voteAverage'],
        voteCount: map['voteCount'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
        'voteAverage': voteAverage,
        'voteCount': voteCount,
      };

  TvSeries toEntity() => TvSeries.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
        voteAverage,
        voteCount,
      ];
}
