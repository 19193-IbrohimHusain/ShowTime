import 'package:showtime_provider/common/constants.dart';
import 'package:showtime_provider/common/utils.dart';
import 'package:showtime_provider/presentation/pages/about_page.dart';
import 'package:showtime_provider/presentation/pages/home_page.dart';
import 'package:showtime_provider/presentation/pages/movie/movie_detail_page.dart';
import 'package:showtime_provider/presentation/pages/movie/popular_movies_page.dart';
import 'package:showtime_provider/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:showtime_provider/presentation/pages/search_page.dart';
import 'package:showtime_provider/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:showtime_provider/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:showtime_provider/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:showtime_provider/presentation/pages/watchlist_page.dart';
import 'package:showtime_provider/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:showtime_provider/presentation/provider/movie/movie_list_notifier.dart';
import 'package:showtime_provider/presentation/provider/movie/movie_search_notifier.dart';
import 'package:showtime_provider/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:showtime_provider/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:showtime_provider/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:showtime_provider/presentation/provider/tv_series/popular_tv_series_notifier.dart';
import 'package:showtime_provider/presentation/provider/tv_series/top_rated_tv_series_notifier.dart';
import 'package:showtime_provider/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:showtime_provider/presentation/provider/tv_series/tv_series_list_notifier.dart';
import 'package:showtime_provider/presentation/provider/tv_series/tv_series_search_notifier.dart';
import 'package:showtime_provider/presentation/provider/tv_series/watchlist_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showtime_provider/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Movie provider
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),

        // Tv Series provider
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'ShowTime Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomePage());
            case PopularMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return MaterialPageRoute(builder: (_) => const SearchPage());
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case PopularTvSeriesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const PopularTvSeriesPage());
            case TopRatedTvSeriesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedTvSeriesPage());
            case TvSeriesDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
