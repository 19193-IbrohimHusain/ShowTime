import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:showtime_getx/common/constants.dart';
import 'package:showtime_getx/common/routes.dart';
import 'package:showtime_getx/domain/entities/movie/movie.dart';
import 'package:showtime_getx/domain/entities/tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showtime_getx/presentation/widgets/shimmer_loading.dart';

class CardList extends StatelessWidget {
  final Movie? movie;
  final TvSeries? tv;
  final bool isMovieCard;

  const CardList({
    super.key,
    this.movie,
    this.tv,
    required this.isMovieCard,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isMovieCard
            ? Get.toNamed(
                RouteName.movieDetail,
                arguments: movie!.id,
              )
            : Get.toNamed(
                RouteName.seriesDetail,
                arguments: tv!.id,
              );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isMovieCard ? movie!.title ?? '-' : tv!.name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: isMovieCard
                              ? movie!.voteAverage! / 2
                              : tv!.voteAverage! / 2,
                          itemCount: 5,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: kMikadoYellow,
                          ),
                          itemSize: 12,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          isMovieCard
                              ? '${movie!.voteAverage}'
                              : '${tv!.voteAverage}',
                          style: kSubtitle,
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      isMovieCard
                          ? movie!.overview ?? '-'
                          : tv!.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 2.0,
                    offset: Offset(1, 2),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: isMovieCard
                      ? '$baseImageUrl${movie!.posterPath}'
                      : '$baseImageUrl${tv!.posterPath}',
                  width: 80,
                  placeholder: (context, url) => const ShimmerLoading(
                    height: 120,
                    width: 80,
                  ),
                  errorWidget: (context, imageUrl, error) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
