import 'package:cached_network_image/cached_network_image.dart';
import 'package:showtime_provider/common/constants.dart';
import 'package:showtime_provider/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:showtime_provider/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:showtime_provider/presentation/widgets/shimmer_loading.dart';

class TvRecommendation extends StatelessWidget {
  const TvRecommendation({
    super.key,
    required this.data,
  });

  final TvSeriesDetailNotifier data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = data.tvRecommendations[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  TvSeriesDetailPage.routeName,
                  arguments: data.tvRecommendations[index].id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tv.posterPath}',
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
        itemCount: data.tvRecommendations.length,
      ),
    );
  }
}
