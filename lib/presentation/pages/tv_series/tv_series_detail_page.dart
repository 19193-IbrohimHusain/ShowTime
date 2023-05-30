import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:showtime_provider/presentation/widgets/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const routeName = '/detail-tvseries';

  final int id;
  const TvSeriesDetailPage({super.key, required this.id});

  @override
  TvSeriesDetailPageState createState() => TvSeriesDetailPageState();
}

class TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .fetchTvDetail(widget.id);
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .loadWatchlistStatusTv(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvState == RequestState.success) {
            final tvSeries = provider.tv;
            return SafeArea(
              child: DetailContent(
                provider.isAddedToWatchlistTv,
                isMovieDetail: false,
                tv: tvSeries,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}
