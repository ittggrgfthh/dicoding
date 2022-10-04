import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_airing_today_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series';

  @override
  _TVSeriesPageState createState() => _TVSeriesPageState();
}

class _TVSeriesPageState extends State<TVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TVListNotifier>(context, listen: false)
      ..fetchTVAiringToday()
      ..fetchPopularTV()
      ..fetchTopRatedTV());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTVPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Airing Today',
                onTap: () =>
                    Navigator.pushNamed(context, TVAiringTodayPage.ROUTE_NAME),
              ),
              Consumer<TVListNotifier>(builder: (context, data, child) {
                final state = data.tvAiringTodayState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.tvAiringToday);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTVPage.ROUTE_NAME),
              ),
              Consumer<TVListNotifier>(builder: (context, data, child) {
                final state = data.popularTVState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.popularTV);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTVPage.ROUTE_NAME),
              ),
              Consumer<TVListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTVState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.topRatedTV);
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVList extends StatelessWidget {
  final List<TV> tv;

  TVList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVDetailPage.ROUTE_NAME,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
