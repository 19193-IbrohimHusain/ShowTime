import 'package:showtime_getx/presentation/controller/movie/movie_controller.dart';
import 'package:showtime_getx/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopRatedMoviesPage extends GetView<MovieController> {
  const TopRatedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) {
              final movie = controller.topRatedMovies[index];
              return CardList(
                isMovieCard: true,
                movie: movie,
              );
            },
            itemCount: controller.topRatedMovies.length,
          ),
        ),
      ),
    );
  }
}
