import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv/tv_airing_today_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/tv_card_list.dart';

class TVAiringTodayPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-airing-today';

  @override
  _TVAiringTodayPageState createState() => _TVAiringTodayPageState();
}

class _TVAiringTodayPageState extends State<TVAiringTodayPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TVAiringTodayNotifier>(context, listen: false)
            .fetchTVAiringToday());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TVAiringTodayNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.tv[index];
                  return TVCard(tvSeries);
                },
                itemCount: data.tv.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
