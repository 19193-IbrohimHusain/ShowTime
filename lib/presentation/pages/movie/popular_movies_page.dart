import 'package:showtime_getx/presentation/controller/movie/movie_controller.dart';
import 'package:showtime_getx/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularMoviesPage extends GetView<MovieController> {
  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) {
              final movie = controller.popularMovies[index];
              return CardList(
                isMovieCard: true,
                movie: movie,
              );
            },
            itemCount: controller.popularMovies.length,
          ),
        ),
      ),
    );
  }
}
