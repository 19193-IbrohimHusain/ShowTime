import 'package:showtime_getx/common/routes.dart';
import 'package:showtime_getx/presentation/controller/movie/watchlist_movie_controller.dart';
import 'package:showtime_getx/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchlistMoviesPage extends GetView<WatchlistMovieController> {
  const WatchlistMoviesPage({super.key});

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
                      "You don't have any movies yet, you can add from the movie list",
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
                final movie = state[index];
                return CardList(
                  isMovieCard: true,
                  movie: movie,
                );
              },
              itemCount: state.length,
            ),
    );
  }
}
