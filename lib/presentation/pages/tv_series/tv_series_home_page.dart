import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:showtime_getx/common/constants.dart';
import 'package:showtime_getx/common/routes.dart';
import 'package:showtime_getx/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_getx/presentation/controller/tv_series/tv_series_controller.dart';
import 'package:showtime_getx/presentation/widgets/shimmer_loading.dart';
import 'package:showtime_getx/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TvSeriesHomePage extends GetView<TvSeriesController> {
  const TvSeriesHomePage({Key? key}) : super(key: key);

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
            onPressed: () => Get.toNamed(RouteName.search),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Airing Today',
                style: kHeading6,
              ),
            ),
            controller.obx(
              (state) => _tvSeriesList(controller.nowPlayingTvSeries, true),
              onLoading: const ShimmerLoading(),
            ),
            SubHeading(
              title: 'Popular',
              onTap: () {
                Get.toNamed(RouteName.popularSeries);
              },
            ),
            Obx(() => _tvSeriesList(controller.popularTvSeries, false)),
            SubHeading(
              title: 'Top Rated',
              onTap: () {
                Get.toNamed(RouteName.topSeries);
              },
            ),
            Obx(() => _tvSeriesList(controller.topRatedTvSeries, false)),
          ],
        ),
      ),
    );
  }

  Widget _tvSeriesList(List<TvSeries> tvSeries, bool isAiring) {
    return isAiring
        ? CarouselSlider.builder(
            itemCount: 5,
            itemBuilder: (context, index, realIndex) {
              final tv = tvSeries[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    RouteName.seriesDetail,
                    arguments: tv.id,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: '$baseImageUrl${tv.backdropPath}',
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
                final tv = tvSeries[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(
                      RouteName.seriesDetail,
                      arguments: tv.id,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: '$baseImageUrl${tv.posterPath}',
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
              itemCount: tvSeries.length,
            ),
          );
  }
}
