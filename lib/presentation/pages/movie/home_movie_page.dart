import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:showtime_getx/common/constants.dart';
import 'package:showtime_getx/common/routes.dart';
import 'package:showtime_getx/domain/entities/movie/movie.dart';
import 'package:showtime_getx/presentation/controller/movie/movie_controller.dart';
import 'package:showtime_getx/presentation/widgets/shimmer_loading.dart';
import 'package:showtime_getx/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMoviePage extends GetView<MovieController> {
  const HomeMoviePage({super.key});

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
                'Now Playing',
                style: kHeading6,
              ),
            ),
            controller.obx(
              (state) => _movieList(controller.nowPlayingMovies, true),
              onLoading: const ShimmerLoading(),
            ),
            SubHeading(
              title: 'Popular',
              onTap: () => Get.toNamed(RouteName.popularMovie),
            ),
            Obx(
              () => _movieList(controller.popularMovies, false),
            ),
            SubHeading(
              title: 'Top Rated',
              onTap: () => Get.toNamed(RouteName.topMovie),
            ),
            Obx(
              () => _movieList(controller.topRatedMovies, false),
            ),
          ],
        ),
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
                  Get.toNamed(
                    RouteName.movieDetail,
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
                    Get.toNamed(
                      RouteName.movieDetail,
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
