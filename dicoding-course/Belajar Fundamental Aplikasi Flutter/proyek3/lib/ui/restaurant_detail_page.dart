import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek3/common/styles.dart';
import 'package:proyek3/data/model/restaurant_list.dart';
import 'package:proyek3/provider/database_provider.dart';
import 'package:proyek3/provider/restaurant_detail_provider.dart';
import 'package:proyek3/widget/card_restaurant_detail.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  const RestaurantDetailPage({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    RestaurantDetailProvider restaurantDetailProvider =
        Provider.of<RestaurantDetailProvider>(context);
    var restaurant = restaurantDetailProvider.result.restaurant;
    return Consumer<DatabaseProvider>(
      builder: (context, value, child) => FutureBuilder(
        future: value.isFavorites(restaurant.id),
        builder: (context, snapshot) {
          isFavorite = snapshot.data ?? false;
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text(
                "Restaurant Detail",
              ),
              foregroundColor: foregroundColor,
              actions: [
                IconButton(
                  icon: isFavorite
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                      if (isFavorite) {
                        value.addFavorites(
                          RestaurantList(
                            id: restaurant.id,
                            name: restaurant.name,
                            description: restaurant.description,
                            pictureId: restaurant.pictureId,
                            city: restaurant.city,
                            rating: restaurant.rating,
                          ),
                        );
                      } else {
                        value.removeFavorite(restaurant.id);
                      }
                    });
                  },
                ),
              ],
            ),
            body: const SingleChildScrollView(
              child: CardRestaurantDetail(),
            ),
          );
        },
      ),
    );
  }
}
