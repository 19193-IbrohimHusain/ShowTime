import 'package:showtime_getx/presentation/controller/tv_series/tv_series_controller.dart';
import 'package:showtime_getx/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularTvSeriesPage extends GetView<TvSeriesController> {
  const PopularTvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) {
              final tv = controller.popularTvSeries[index];
              return CardList(
                isMovieCard: false,
                tv: tv,
              );
            },
            itemCount: controller.popularTvSeries.length,
          ),
        ),
      ),
    );
  }
}
