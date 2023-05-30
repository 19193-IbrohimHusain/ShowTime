import 'package:showtime_getx/data/datasources/db/database_helper.dart';
import 'package:showtime_getx/data/datasources/db/database_helper_tv_series.dart';
import 'package:showtime_getx/data/datasources/movie/movie_local_data_source.dart';
import 'package:showtime_getx/data/datasources/movie/movie_remote_data_source.dart';
import 'package:showtime_getx/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:showtime_getx/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:showtime_getx/data/repositories/movie_repository_impl.dart';
import 'package:showtime_getx/data/repositories/tv_series_repository_impl.dart';
import 'package:showtime_getx/domain/repositories/movie_repository.dart';
import 'package:showtime_getx/domain/repositories/tv_series_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Movie Repository
    Get.lazyPut<MovieRepository>(
      () => MovieRepositoryImpl(
        remoteDataSource: Get.find<MovieRemoteDataSource>(),
        localDataSource: Get.find<MovieLocalDataSource>(),
      ),
    );

    // Tv Series Repository
    Get.lazyPut<TvSeriesRepository>(
      () => TvSeriesRepositoryImpl(
        remoteDataSource: Get.find<TvSeriesRemoteDataSource>(),
        localDataSource: Get.find<TvSeriesLocalDataSource>(),
      ),
    );

    // Movie Datasources
    Get.lazyPut<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(
        client: Get.find<http.Client>(),
      ),
    );
    Get.lazyPut<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(
        databaseHelper: Get.find<DatabaseHelper>(),
      ),
    );

    // Tv Series Datasources
    Get.lazyPut<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(
        client: Get.find<http.Client>(),
      ),
    );
    Get.lazyPut<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(
        databaseHelper: Get.find<DatabaseHelperTvSeries>(),
      ),
    );

    // Movie Database Helper
    Get.put(DatabaseHelper());

    // Tv Series Database Helper
    Get.put(DatabaseHelperTvSeries());

    // external
    Get.put(http.Client());
  }
}
