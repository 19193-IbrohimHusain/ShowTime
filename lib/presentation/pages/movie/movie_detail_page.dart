import 'package:showtime_getx/presentation/controller/movie/movie_detail_controller.dart';
import 'package:showtime_getx/presentation/widgets/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailPage extends GetView<MovieDetailController> {
  const MovieDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: controller.obx(
          (data) => DetailContent(
            controller.isAddedToWatchlist,
            isMovieDetail: true,
            movie: data,
          ),
        ),
      ),
    );
  }
}
