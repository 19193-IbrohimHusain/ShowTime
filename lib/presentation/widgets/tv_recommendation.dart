import 'package:cached_network_image/cached_network_image.dart';
import 'package:showtime_getx/common/constants.dart';
import 'package:showtime_getx/common/routes.dart';
import 'package:showtime_getx/presentation/bindings/tv_series/tv_series_detail_binding.dart';
import 'package:showtime_getx/presentation/controller/tv_series/tv_series_detail_controller.dart';
import 'package:showtime_getx/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showtime_getx/presentation/widgets/shimmer_loading.dart';

class TvRecommendation extends GetView<TvSeriesDetailController> {
  const TvRecommendation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final tv = controller.tvSeriesRecommendations[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  Get.off(
                    const TvSeriesDetailPage(),
                    routeName: RouteName.seriesDetail,
                    arguments: controller.tvSeriesRecommendations[index].id,
                    binding: TvSeriesDetailBindings(),
                    preventDuplicates: false,
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
          itemCount: controller.tvSeriesRecommendations.length,
        ),
      ),
    );
  }
}
