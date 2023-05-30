import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/common/utils.dart';
import 'package:showtime_provider/presentation/pages/home_page.dart';
import 'package:showtime_provider/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:showtime_provider/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  WatchlistMoviesPageState createState() => WatchlistMoviesPageState();
}

class WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistMovieNotifier>(
      builder: (context, data, child) {
        if (data.watchlistState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.watchlistMovies.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "You don't have any movies yet, you can add from the movie list",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
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
              final movie = data.watchlistMovies[index];
              return CardList(
                isMovieCard: true,
                movie: movie,
              );
            },
            itemCount: data.watchlistMovies.length,
          );
        } else {
          return Container();
          // return Center(
          //   key: const Key('error_message'),
          //   child: Text(data.message),
          // );
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
