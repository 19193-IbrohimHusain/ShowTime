import 'package:showtime_provider/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/presentation/widgets/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail';

  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  MovieDetailPageState createState() => MovieDetailPageState();
}

class MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .fetchMovieDetail(widget.id);
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.movieState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.movieState == RequestState.success) {
            return SafeArea(
              child: DetailContent(
                provider.isAddedToWatchlist,
                isMovieDetail: true,
                movie: provider.movie,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}
