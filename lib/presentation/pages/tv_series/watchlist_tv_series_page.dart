import 'package:showtime_getx/common/routes.dart';
import 'package:showtime_getx/presentation/controller/tv_series/watchlist_tv_series_controller.dart';
import 'package:showtime_getx/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchlistTvSeriesPage extends GetView<WatchlistTvSeriesController> {
  const WatchlistTvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => state!.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "You don't have any series yet, you can add from the series list",
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () => Get.offNamedUntil(
                        RouteName.home,
                        (route) => true,
                      ),
                      child: const Text('Add Watchlist'),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                final tv = state[index];
                return CardList(
                  isMovieCard: false,
                  tv: tv,
                );
              },
              itemCount: state.length,
            ),
    );
  }
}
