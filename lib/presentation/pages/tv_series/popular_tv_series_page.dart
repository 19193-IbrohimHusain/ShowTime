import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/presentation/provider/tv_series/popular_tv_series_notifier.dart';
import 'package:showtime_provider/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const routeName = '/popular-tvseries';

  const PopularTvSeriesPage({super.key});

  @override
  PopularTvSeriesPageState createState() => PopularTvSeriesPageState();
}

class PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvSeriesNotifier>(context, listen: false)
            .fetchPopularTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.success) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvSeries[index];
                  return CardList(
                    isMovieCard: false,
                    tv: tv,
                  );
                },
                itemCount: data.tvSeries.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
