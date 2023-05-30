import 'package:showtime_getx/data/models/tv_series/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> tvSeriesList;

  const TvSeriesResponse({required this.tvSeriesList});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
        tvSeriesList: List<TvSeriesModel>.from((json["results"] as List)
            .map((x) => TvSeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  @override
  List<Object> get props => [tvSeriesList];
}
