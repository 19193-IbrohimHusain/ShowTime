import 'package:cached_network_image/cached_network_image.dart';
import 'package:showtime_getx/common/constants.dart';
import 'package:showtime_getx/domain/entities/genre.dart';
import 'package:showtime_getx/domain/entities/movie/movie_detail.dart';
import 'package:showtime_getx/domain/entities/tv_series/tv_series_detail.dart';
import 'package:showtime_getx/presentation/controller/movie/movie_detail_controller.dart';
import 'package:showtime_getx/presentation/controller/tv_series/tv_series_detail_controller.dart';
import 'package:showtime_getx/presentation/widgets/movie_recommendation.dart';
import 'package:showtime_getx/presentation/widgets/tv_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

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
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
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
                              await _isAddedWatchlistMovie();
                            } else {
                              await _isAddedWatchlistTv();
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
                            ? const MovieRecommendation()
                            : const TvRecommendation(),
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
                Get.back();
              },
            ),
          ),
        )
      ],
    );
  }

  Future<void> _isAddedWatchlistTv() async {
    TvSeriesDetailController tvController = Get.find();
    if (isAddedWatchlist == false) {
      await tvController.addWatchlistTvSeries(tv!);
    } else {
      await tvController.removeFromWatchlistTvSeries(tv!);
    }
  }

  Future<void> _isAddedWatchlistMovie() async {
    MovieDetailController movieController = Get.find();
    if (isAddedWatchlist == false) {
      await movieController.addWatchlist(movie!);
    } else {
      await movieController.removeFromWatchlist(movie!);
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
