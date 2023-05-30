import 'package:showtime_provider/presentation/pages/about_page.dart';
import 'package:showtime_provider/presentation/pages/movie/home_movie_page.dart';
import 'package:showtime_provider/presentation/pages/tv_series/tv_series_home_page.dart';
import 'package:showtime_provider/presentation/pages/watchlist_page.dart';
import 'package:showtime_provider/presentation/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  HomeMoviePageState createState() => HomeMoviePageState();
}

class HomeMoviePageState extends State<HomePage> {
  int _selectedPage = 0;
  final _page = const <Widget>[
    MovieHomePage(),
    TvSeriesHomePage(),
    WatchlistPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectedPage],
      bottomNavigationBar: BottomNavBar(
        selectedPage: _selectedPage,
        onTap: (index) => setState(() => _selectedPage = index),
      ),
    );
  }
}
