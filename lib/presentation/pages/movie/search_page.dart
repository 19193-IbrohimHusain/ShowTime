import 'package:showtime_provider/common/constants.dart';
import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/presentation/provider/movie/movie_search_notifier.dart';
import 'package:showtime_provider/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPageMovies extends StatelessWidget {
  static const routeName = '/search';

  const SearchPageMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
            onChanged: (query) {
              Provider.of<MovieSearchNotifier>(context, listen: false)
                  .fetchMovieSearch(query);
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Search Result',
            style: kHeading6,
          ),
          Consumer<MovieSearchNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == RequestState.success) {
                final result = data.searchResult;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = data.searchResult[index];
                      return CardList(
                        isMovieCard: true,
                        movie: movie,
                      );
                    },
                    itemCount: result.length,
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
