import 'package:cached_network_image/cached_network_image.dart';
import 'package:showtime_provider/common/constants.dart';
import 'package:showtime_provider/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:showtime_provider/presentation/pages/movie/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:showtime_provider/presentation/widgets/shimmer_loading.dart';

class MovieRecommendation extends StatelessWidget {
  const MovieRecommendation({
    super.key,
    required this.data,
  });

  final MovieDetailNotifier data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = data.movieRecommendations[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: data.movieRecommendations[index].id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const ShimmerLoading(
                    height: 120,
                    width: 90,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: data.movieRecommendations.length,
      ),
    );
  }
}
