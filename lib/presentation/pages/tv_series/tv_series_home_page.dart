import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:showtime_provider/common/constants.dart';
import 'package:showtime_provider/common/state_enum.dart';
import 'package:showtime_provider/domain/entities/tv_series/tv_series.dart';
import 'package:showtime_provider/presentation/pages/search_page.dart';
import 'package:showtime_provider/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:showtime_provider/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:showtime_provider/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:showtime_provider/presentation/provider/tv_series/tv_series_list_notifier.dart';
import 'package:showtime_provider/presentation/widgets/shimmer_loading.dart';
import 'package:showtime_provider/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesHomePage extends StatefulWidget {
  const TvSeriesHomePage({Key? key}) : super(key: key);
  static const routeName = '/tvseries-page';

  @override
  TvSeriesHomePageState createState() => TvSeriesHomePageState();
}

class TvSeriesHomePageState extends State<TvSeriesHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchNowPlayingTv()
      ..fetchPopularTv()
      ..fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'ShowTime',
          style: kHeading5.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, SearchPage.routeName),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Airing Today',
                style: kHeading6,
              ),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingTvState;
              if (state == RequestState.loading) {
                return const ShimmerLoading();
              } else if (state == RequestState.success) {
                return _tvSeriesList(data.nowPlayingTv, true);
              } else {
                return const Text('Failed');
              }
            }),
            SubHeading(
              title: 'Popular',
              onTap: () {
                Navigator.pushNamed(context, PopularTvSeriesPage.routeName);
              },
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.popularTvState;
              if (state == RequestState.loading) {
                return const ShimmerLoading();
              } else if (state == RequestState.success) {
                return _tvSeriesList(data.popularTv, false);
              } else {
                return const Text('Failed');
              }
            }),
            SubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.routeName);
                }),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.topRatedTvState;
              if (state == RequestState.loading) {
                return const ShimmerLoading();
              } else if (state == RequestState.success) {
                return _tvSeriesList(data.topRatedTv, false);
              } else {
                return const Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _tvSeriesList(List<TvSeries> tvSeries, bool isAiring) {
    return isAiring
        ? CarouselSlider.builder(
            itemCount: 5,
            itemBuilder: (context, index, realIndex) {
              final tv = tvSeries[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TvSeriesDetailPage.routeName,
                    arguments: tv.id,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: '$baseImageUrl${tv.backdropPath}',
                      placeholder: (context, url) => const ShimmerLoading(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              viewportFraction: 1.0,
            ),
          )
        : SizedBox(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tv = tvSeries[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      TvSeriesDetailPage.routeName,
                      arguments: tv.id,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: '$baseImageUrl${tv.posterPath}',
                        placeholder: (context, url) => const ShimmerLoading(
                          height: 80,
                          width: 125,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: tvSeries.length,
            ),
          );
  }
}
