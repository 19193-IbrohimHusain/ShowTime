import 'package:showtime_provider/common/constants.dart';
import 'package:showtime_provider/presentation/pages/tv_series/watchlist_tv_series_page.dart';
import 'package:showtime_provider/presentation/widgets/tab_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:showtime_provider/presentation/pages/movie/watchlist_movies_page.dart';

class WatchlistPage extends StatelessWidget {
  static const routeName = '/watchlistPage';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return const <Widget>[
              SliverAppBar(
                title: Text('Watchlist'),
                pinned: true,
                floating: true,
                bottom: TabBar(
                  indicatorColor: kMikadoYellow,
                  tabs: [
                    TabBarItem(tabMovie: true),
                    TabBarItem(tabMovie: false),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: <Widget>[
              WatchlistMoviesPage(),
              WatchlistTvSeriesPage(),
            ],
          ),
        ),
      ),
    );
  }
}
