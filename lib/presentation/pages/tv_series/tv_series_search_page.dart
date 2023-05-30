import 'package:showtime_getx/common/constants.dart';
import 'package:showtime_getx/presentation/controller/tv_series/tv_series_search_controller.dart';
import 'package:showtime_getx/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageTvSeries extends GetView<TvSeriesSearchController> {
  const SearchPageTvSeries({super.key});

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
              controller.fetchTvSeriesSearch(query);
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Search Result',
            style: kHeading6,
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final tv = controller.searchResult[index];
                  return CardList(
                    isMovieCard: false,
                    tv: tv,
                  );
                },
                itemCount: controller.searchResult.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
