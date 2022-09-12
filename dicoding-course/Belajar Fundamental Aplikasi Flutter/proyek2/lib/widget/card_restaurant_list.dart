import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek2/common/styles.dart';
import 'package:proyek2/data/model/restaurant_detail.dart';
import 'package:proyek2/data/model/restaurant_list.dart';
import 'package:proyek2/provider/restaurant_detail_provider.dart';
import 'package:proyek2/ui/restaurant_detail_page.dart';

class CardRestaurantList extends StatelessWidget {
  final RestaurantList restaurantList;
  const CardRestaurantList({super.key, required this.restaurantList});

  @override
  Widget build(BuildContext context) {
    final pictureId = restaurantList.pictureId;
    const pictureSize = 'medium';
    final urlToImage =
        'https://restaurant-api.dicoding.dev/images/$pictureSize/$pictureId';
    return Material(
      color: itemForegroundColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: urlToImage,
          child: Image.network(
            urlToImage,
            width: 100,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.chevron_right,
              color: textForegroundColor,
            ),
          ],
        ),
        title: Text(
          restaurantList.name,
          style: const TextStyle(
            color: textForegroundColor,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: Text(
                restaurantList.city,
                style: const TextStyle(
                  color: textForegroundColor,
                ),
              ),
            ),
            Row(
              children: [
                const Expanded(
                  flex: 0,
                  child: Icon(
                    Icons.star,
                    color: textForegroundColor,
                  ),
                ),
                Flexible(
                  child: Text(
                    restaurantList.rating.toString(),
                    style: const TextStyle(
                      color: textForegroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          final restaurantDetailProvider =
              Provider.of<RestaurantDetailProvider>(context, listen: false);
          final restaurantDetail = RestaurantDetail(
              id: restaurantList.id,
              name: restaurantList.name,
              description: restaurantList.description,
              city: restaurantList.city,
              address: "",
              pictureId: restaurantList.pictureId,
              rating: restaurantList.rating,
              categories: [],
              menus: Menus(drinks: [], foods: []),
              customerReviews: []);
          final restaurantDetailModel = RestaurantDetailModel(
              error: false, message: "", restaurant: restaurantDetail);
          restaurantDetailProvider.setRestaurantDetail(restaurantDetailModel);
          Navigator.pushNamed(
            context,
            RestaurantDetailPage.routeName,
          );
        },
      ),
    );
  }
}
