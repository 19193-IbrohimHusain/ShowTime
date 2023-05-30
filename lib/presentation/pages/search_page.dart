import 'package:showtime_getx/common/constants.dart';
import 'package:showtime_getx/presentation/pages/movie/search_page.dart';
import 'package:showtime_getx/presentation/pages/tv_series/tv_series_search_page.dart';
import 'package:showtime_getx/presentation/widgets/tab_bar_item.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return const <Widget>[
            SliverAppBar(
              title: Text('Search'),
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
            SearchPageMovies(),
            SearchPageTvSeries(),
          ],
        ),
      )),
    );
  }
}
