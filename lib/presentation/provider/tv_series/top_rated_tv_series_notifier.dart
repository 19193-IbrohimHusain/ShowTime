import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_provider/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

class TopRatedTvSeriesNotifier extends ChangeNotifier {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesNotifier({required this.getTopRatedTvSeries});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvData) {
        _tvSeries = tvData;
        _state = RequestState.success;
        notifyListeners();
      },
    );
  }
}
