import 'package:showtime_getx/presentation/controller/tv_series/tv_series_detail_controller.dart';
import 'package:showtime_getx/presentation/widgets/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TvSeriesDetailPage extends GetView<TvSeriesDetailController> {
  const TvSeriesDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: controller.obx(
          (data) => DetailContent(
            controller.isAddedToWatchlist,
            isMovieDetail: false,
            tv: data,
          ),
        ),
      ),
    );
  }
}
