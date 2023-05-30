import 'package:showtime_getx/common/state_enum.dart';
import 'package:showtime_getx/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_getx/domain/usecases/tv_series/search_tv_series.dart';
import 'package:get/get.dart';

class TvSeriesSearchController extends GetxController {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchController(this.searchTvSeries);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  final _searchResult = <TvSeries>[].obs;
  List<TvSeries> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesSearch(String query) async {
    _state = RequestState.loading;
    update();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        update();
      },
      (data) {
        _searchResult.value = data;
        _state = RequestState.success;
        update();
      },
    );
  }

  @override
  void onInit() {
    fetchTvSeriesSearch('');
    super.onInit();
  }
}
