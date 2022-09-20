import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek3/common/styles.dart';
import 'package:proyek3/provider/database_provider.dart';
import 'package:proyek3/provider/result_state.dart';
import 'package:proyek3/widget/card_restaurant_list.dart';
import 'package:proyek3/widget/error_no_internet.dart';

class FavoritePage extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
        ),
        foregroundColor: foregroundColor,
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                var restaurantList = state.favorites[index];
                return CardRestaurantList(restaurantList: restaurantList);
              },
            );
          } else if (state.state == ResultState.noData) {
            return const Center(
              child: Material(
                color: foregroundColor,
                child: Text(
                  'Anda belum menambahkan Favorite',
                  style: TextStyle(color: textForegroundColor),
                ),
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
      ),
    );
  }
}
