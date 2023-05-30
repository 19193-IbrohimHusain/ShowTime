import 'package:showtime_getx/presentation/bindings/movie/movie_binding.dart';
import 'package:showtime_getx/presentation/bindings/movie/movie_detail_binding.dart';
import 'package:showtime_getx/presentation/bindings/movie/movie_search_binding.dart';
import 'package:showtime_getx/presentation/bindings/movie/watchlist_movie_binding.dart';
import 'package:showtime_getx/presentation/bindings/tv_series/tv_series_binding.dart';
import 'package:showtime_getx/presentation/bindings/tv_series/tv_series_detail_binding.dart';
import 'package:showtime_getx/presentation/bindings/tv_series/tv_series_search_binding.dart';
import 'package:showtime_getx/presentation/bindings/tv_series/watchlist_tv_series_binding.dart';
import 'package:showtime_getx/presentation/pages/about_page.dart';
import 'package:showtime_getx/presentation/pages/home_page.dart';
import 'package:showtime_getx/presentation/pages/movie/home_movie_page.dart';
import 'package:showtime_getx/presentation/pages/movie/movie_detail_page.dart';
import 'package:showtime_getx/presentation/pages/movie/popular_movies_page.dart';
import 'package:showtime_getx/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:showtime_getx/presentation/pages/search_page.dart';
import 'package:showtime_getx/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:showtime_getx/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:showtime_getx/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:showtime_getx/presentation/pages/tv_series/tv_series_home_page.dart';
import 'package:showtime_getx/presentation/pages/watchlist_page.dart';
import 'package:get/get.dart';

class AppPage {
  static final routes = [
    GetPage(
      name: RouteName.home,
      page: () => const HomePage(),
      bindings: [
        MovieBindings(),
        TvSeriesBindings(),
        WatchlistMovieBinding(),
        WatchlistTvSeriesBinding(),
      ],
    ),
    GetPage(
      name: RouteName.movie,
      page: () => const HomeMoviePage(),
      binding: MovieBindings(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.popularMovie,
      page: () => const PopularMoviesPage(),
      binding: MovieBindings(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.topMovie,
      page: () => const TopRatedMoviesPage(),
      binding: MovieBindings(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.movieDetail,
      page: () => const MovieDetailPage(),
      binding: MovieDetailBindings(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.series,
      page: () => const TvSeriesHomePage(),
      binding: TvSeriesBindings(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.popularSeries,
      page: () => const PopularTvSeriesPage(),
      binding: TvSeriesBindings(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.topSeries,
      page: () => const TopRatedTvSeriesPage(),
      binding: TvSeriesBindings(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.seriesDetail,
      page: () => const TvSeriesDetailPage(),
      binding: TvSeriesDetailBindings(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.search,
      page: () => const SearchPage(),
      bindings: [
        MovieSearchBinding(),
        TvSeriesSearchBinding(),
      ],
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.watchlist,
      page: () => const WatchlistPage(),
      bindings: [
        WatchlistMovieBinding(),
        WatchlistTvSeriesBinding(),
      ],
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.about,
      page: () => const AboutPage(),
      transition: Transition.fade,
    ),
  ];
}

abstract class RouteName {
  static const home = '/home';
  static const movie = '/home/movie';
  static const popularMovie = '/home/movie/popular';
  static const topMovie = '/home/movie/top';
  static const movieDetail = '/home/movie/detail';
  static const series = '/home/series';
  static const popularSeries = '/home/series/popular';
  static const topSeries = '/home/series/top';
  static const seriesDetail = '/home/series/detail';
  static const search = '/home/search';
  static const watchlist = '/home/watchlist';
  static const about = '/home/about';
}
