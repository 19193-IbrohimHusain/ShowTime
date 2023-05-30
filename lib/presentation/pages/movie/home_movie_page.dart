import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:showtime_provider/common/constants.dart';
import 'package:showtime_provider/domain/entities/movie/movie.dart';
import 'package:showtime_provider/presentation/pages/movie/movie_detail_page.dart';
import 'package:showtime_provider/presentation/pages/movie/popular_movies_page.dart';
import 'package:showtime_provider/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:showtime_provider/presentation/provider/movie/movie_list_notifier.dart';
import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/presentation/pages/search_page.dart';
import 'package:showtime_provider/presentation/widgets/shimmer_loading.dart';
import 'package:showtime_provider/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({super.key});

  @override
  MovieHomePageState createState() => MovieHomePageState();
}

class MovieHomePageState extends State<MovieHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'ShowTime',
          style: kHeading5.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, SearchPage.routeName),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Consumer<MovieListNotifier>(
        builder: (context, data, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Now Playing',
                    style: kHeading6,
                  ),
                ),
                Consumer<MovieListNotifier>(builder: (context, data, child) {
                  final state = data.nowPlayingState;
                  if (state == RequestState.loading) {
                    return const ShimmerLoading();
                  } else if (state == RequestState.loading) {
                    return const Center(
                      child: ShimmerLoading(),
                    );
                  } else if (state == RequestState.success) {
                    return _movieList(data.nowPlayingMovies, true);
                  } else {
                    return const Text('Failed');
                  }
                }),
                SubHeading(
                  title: 'Popular',
                  onTap: () =>
                      Navigator.pushNamed(context, PopularMoviesPage.routeName),
                ),
                Consumer<MovieListNotifier>(builder: (context, data, child) {
                  final state = data.popularMoviesState;
                  if (state == RequestState.loading) {
                    return const ShimmerLoading();
                  } else if (state == RequestState.loading) {
                    return const Center(
                      child: ShimmerLoading(),
                    );
                  } else if (state == RequestState.success) {
                    return _movieList(data.popularMovies, false);
                  } else {
                    return const Text('Failed');
                  }
                }),
                SubHeading(
                  title: 'Top Rated',
                  onTap: () => Navigator.pushNamed(
                      context, TopRatedMoviesPage.routeName),
                ),
                Consumer<MovieListNotifier>(builder: (context, data, child) {
                  final state = data.topRatedMoviesState;
                  if (state == RequestState.loading) {
                    return const ShimmerLoading();
                  } else if (state == RequestState.loading) {
                    return const Center(
                      child: ShimmerLoading(),
                    );
                  } else if (state == RequestState.success) {
                    return _movieList(data.topRatedMovies, false);
                  } else {
                    return const Text('Failed');
                  }
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _movieList(List<Movie> movies, bool isNowPlaying) {
    return isNowPlaying
        ? CarouselSlider.builder(
            itemCount: 5,
            itemBuilder: (context, index, realIndex) {
              final movie = movies[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MovieDetailPage.routeName,
                    arguments: movie.id,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: '$baseImageUrl${movie.backdropPath}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ShimmerLoading(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              viewportFraction: 1.0,
            ),
          )
        : SizedBox(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailPage.routeName,
                      arguments: movie.id,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: '$baseImageUrl${movie.posterPath}',
                        placeholder: (context, url) => const ShimmerLoading(
                          height: 80,
                          width: 125,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: movies.length,
            ),
          );
  }
}
