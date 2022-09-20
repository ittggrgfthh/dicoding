import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyek3/common/styles.dart';
import 'package:proyek3/provider/restaurant_list_provider.dart';
import 'package:proyek3/provider/result_state.dart';
import 'package:proyek3/ui/search_page.dart';
import 'package:proyek3/widget/card_restaurant_list.dart';
import 'package:proyek3/widget/error_no_internet.dart';
import 'package:proyek3/widget/platform_widget.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  Widget _buildList() {
    return Consumer<RestaurantListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurantList.length,
            itemBuilder: (context, index) {
              var restaurantList = state.result.restaurantList[index];
              return CardRestaurantList(restaurantList: restaurantList);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return const ErrorNoInternet();
        } else {
          return const Center(
            child: Material(
              child: Text('Restaurant is missing'),
            ),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant App',
        ),
        foregroundColor: foregroundColor,
        actions: <Widget>[
          ElevatedButton(
            child: const Icon(
              Icons.search_rounded,
            ),
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Restaurant App',
          style: TextStyle(
            color: foregroundColor,
          ),
        ),
        transitionBetweenRoutes: false,
        trailing: Icon(CupertinoIcons.search),
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
