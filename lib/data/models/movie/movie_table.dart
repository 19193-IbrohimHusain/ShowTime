import 'package:showtime_getx/domain/entities/movie/movie.dart';
import 'package:showtime_getx/domain/entities/movie/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieTable extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final double voteAverage;
  final int voteCount;

  const MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        voteAverage: map['voteAverage'],
        voteCount: map['voteCount'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'voteAverage': voteAverage,
        'voteCount': voteCount,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        posterPath,
        overview,
        voteAverage,
        voteCount,
      ];
}
