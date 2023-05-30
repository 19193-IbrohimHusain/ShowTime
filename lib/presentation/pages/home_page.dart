import 'package:showtime_getx/presentation/controller/movie/movie_controller.dart';
import 'package:showtime_getx/presentation/controller/movie/watchlist_movie_controller.dart';
import 'package:showtime_getx/presentation/controller/tv_series/tv_series_controller.dart';
import 'package:showtime_getx/presentation/controller/tv_series/watchlist_tv_series_controller.dart';
import 'package:showtime_getx/presentation/pages/about_page.dart';
import 'package:showtime_getx/presentation/pages/movie/home_movie_page.dart';
import 'package:showtime_getx/presentation/pages/tv_series/tv_series_home_page.dart';
import 'package:showtime_getx/presentation/pages/watchlist_page.dart';
import 'package:showtime_getx/presentation/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  HomeMoviePageState createState() => HomeMoviePageState();
}

class HomeMoviePageState extends State<HomePage> {
  int _selectedPage = 0;
  final _page = const <Widget>[
    HomeMoviePage(),
    TvSeriesHomePage(),
    WatchlistPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    MovieController movie = Get.find();
    TvSeriesController tvSeries = Get.find();
    WatchlistMovieController watchlistMovie = Get.find();
    WatchlistTvSeriesController watchlistTv = Get.find();

    return Scaffold(
      body: _page[_selectedPage],
      bottomNavigationBar: BottomNavBar(
        selectedPage: _selectedPage,
        onTap: (index) async {
          switch (index) {
            case 0:
              setState(() {
                _selectedPage = 0;
                movie.fetchNowPlayingMovies();
                movie.fetchPopularMovies();
                movie.fetchTopRatedMovies();
              });
              break;
            case 1:
              setState(() {
                _selectedPage = 1;
                tvSeries.fetchNowPlayingTvSeries();
                tvSeries.fetchPopularTvSeries();
                tvSeries.fetchTopRatedTvSeries();
              });
              break;
            case 2:
              setState(() {
                _selectedPage = 2;
                watchlistMovie.fetchWatchlistMovies();
                watchlistTv.fetchWatchlistTvSeries();
              });
              break;
            case 3:
              setState(() {
                _selectedPage = 3;
              });
              break;
          }
        },
      ),
    );
  }
}
