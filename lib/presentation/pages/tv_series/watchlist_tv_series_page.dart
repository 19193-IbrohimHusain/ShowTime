import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/common/utils.dart';
import 'package:showtime_provider/presentation/pages/home_page.dart';
import 'package:showtime_provider/presentation/provider/tv_series/watchlist_tv_series_notifier.dart';
import 'package:showtime_provider/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  static const routeName = '/watchlist-tvseries';

  const WatchlistTvSeriesPage({super.key});

  @override
  WatchlistTvSeriesPageState createState() => WatchlistTvSeriesPageState();
}

class WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
            .fetchWatchlistTvSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistTvSeriesNotifier>(
      builder: (context, data, child) {
        if (data.watchlistState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.watchlistTvSeries.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "You don't have any series yet, you can add from the series list",
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      HomePage.routeName,
                      (route) => true,
                    ),
                    child: const Text('Add Watchlist'),
                  ),
                ],
              ),
            ),
          );
        } else if (data.watchlistState == RequestState.success) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tv = data.watchlistTvSeries[index];
              return CardList(
                isMovieCard: false,
                tv: tv,
              );
            },
            itemCount: data.watchlistTvSeries.length,
          );
        } else {
          return Center(
            key: const Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
