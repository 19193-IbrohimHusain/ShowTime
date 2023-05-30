import 'package:cached_network_image/cached_network_image.dart';
import 'package:showtime_provider/common/constants.dart';
import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/domain/entities/genre.dart';
import 'package:showtime_provider/domain/entities/movie/movie_detail.dart';
import 'package:showtime_provider/domain/entities/tv_series/tv_series_detail.dart';
import 'package:showtime_provider/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:showtime_provider/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:showtime_provider/presentation/widgets/movie_recommendation.dart';
import 'package:showtime_provider/presentation/widgets/shimmer_loading.dart';
import 'package:showtime_provider/presentation/widgets/tv_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class DetailContent extends StatelessWidget {
  final MovieDetail? movie;
  final TvSeriesDetail? tv;
  final bool isAddedWatchlist;
  final bool isMovieDetail;

  const DetailContent(this.isAddedWatchlist,
      {super.key, this.movie, this.tv, required this.isMovieDetail});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: isMovieDetail
              ? '$baseImageUrl${movie!.posterPath}'
              : '$baseImageUrl${tv!.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const ShimmerLoading(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.3,
          maxChildSize: 0.75,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: kRichBlack,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          isMovieDetail ? movie!.title : tv!.name,
                          style: kHeading5,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (isMovieDetail == true) {
                              await _isAddedWatchlistMovie(context);
                            } else {
                              await _isAddedWatchlistTv(context);
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              isAddedWatchlist
                                  ? const Icon(Icons.check)
                                  : const Icon(Icons.add),
                              const Text('Watchlist'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _showGenres(
                            isMovieDetail ? movie!.genres : tv!.genres,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          isMovieDetail
                              ? _showDuration(movie!.runtime)
                              : tv!.firstAirDate,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: isMovieDetail
                                  ? movie!.voteAverage / 2
                                  : tv!.voteAverage / 2,
                              itemCount: 5,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: kMikadoYellow,
                              ),
                              itemSize: 24,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              isMovieDetail
                                  ? '${movie!.voteAverage}'
                                  : '${tv!.voteAverage}',
                              style: kSubtitle,
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Overview',
                          style: kHeading6,
                        ),
                        Text(
                          isMovieDetail ? movie!.overview : tv!.overview,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Recommendations',
                          style: kHeading6,
                        ),
                        isMovieDetail
                            ? Consumer<MovieDetailNotifier>(
                                builder: (context, data, child) {
                                  if (data.recommendationState ==
                                      RequestState.loading) {
                                    return const ShimmerLoading();
                                  } else if (data.recommendationState ==
                                      RequestState.error) {
                                    return Text(data.message);
                                  } else if (data.recommendationState ==
                                      RequestState.success) {
                                    return MovieRecommendation(data: data);
                                  } else {
                                    return Container();
                                  }
                                },
                              )
                            : Consumer<TvSeriesDetailNotifier>(
                                builder: (context, data, child) {
                                  if (data.recommendationTvState ==
                                      RequestState.loading) {
                                    return const ShimmerLoading();
                                  } else if (data.recommendationTvState ==
                                      RequestState.error) {
                                    return Text(data.message);
                                  } else if (data.recommendationTvState ==
                                      RequestState.success) {
                                    return TvRecommendation(data: data);
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Colors.white,
                      height: 4,
                      width: 48,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  Future<void> _isAddedWatchlistTv(BuildContext context) async {
    if (isAddedWatchlist) {
      await Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .removeFromWatchlistTv(tv!);
    } else {
      await Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .addWatchlistTv(tv!);
    }
    final message = Provider.of<TvSeriesDetailNotifier>(context, listen: false)
        .watchlistMessageTv;
    if (message == MovieDetailNotifier.watchlistAddSuccessMessage ||
        message == MovieDetailNotifier.watchlistRemoveSuccessMessage) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(message),
            );
          });
    }
  }

  Future<void> _isAddedWatchlistMovie(BuildContext context) async {
    if (isAddedWatchlist) {
      await Provider.of<MovieDetailNotifier>(context, listen: false)
          .removeFromWatchlist(movie!);
    } else {
      await Provider.of<MovieDetailNotifier>(context, listen: false)
          .addWatchlist(movie!);
    }
    final message = Provider.of<MovieDetailNotifier>(context, listen: false)
        .watchlistMessage;
    if (message == MovieDetailNotifier.watchlistAddSuccessMessage ||
        message == MovieDetailNotifier.watchlistRemoveSuccessMessage) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(message),
            );
          });
    }
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
