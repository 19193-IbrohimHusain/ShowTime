import 'dart:convert';
import 'package:showtime_provider/common/exception.dart';
import 'package:showtime_provider/data/models/tv_series/tv_series_detail_model.dart';
import 'package:showtime_provider/data/models/tv_series/tv_series_model.dart';
import 'package:showtime_provider/data/models/tv_series/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlaying();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<TvDetailResponse> getDetailTvSeries(int id);
  Future<List<TvSeriesModel>> getRecommendedTvSeries(int id);
  Future<List<TvSeriesModel>> getSearchTv(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getNowPlaying() async {
    try {
      final response =
          await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));

      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    try {
      final response =
          await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    try {
      final response =
          await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getDetailTvSeries(int id) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

      return TvDetailResponse.fromJson(json.decode(response.body));
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getRecommendedTvSeries(int id) async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getSearchTv(String query) async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } catch (e) {
      throw ServerException();
    }
  }
}
