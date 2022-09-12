import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek2/common/styles.dart';
import 'package:proyek2/data/model/restaurant_detail.dart';
import 'package:proyek2/data/model/search.dart';
import 'package:proyek2/provider/restaurant_detail_provider.dart';
import 'package:proyek2/ui/restaurant_detail_page.dart';

class CardSearch extends StatelessWidget {
  final SearchRestaurant searchModel;
  const CardSearch({super.key, required this.searchModel});

  @override
  Widget build(BuildContext context) {
    final pictureId = searchModel.pictureId;
    const pictureSize = 'small';
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
          searchModel.name,
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
                searchModel.city,
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
                    searchModel.rating.toString(),
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
              id: searchModel.id,
              name: searchModel.name,
              description: searchModel.description,
              city: searchModel.city,
              address: "",
              pictureId: searchModel.pictureId,
              rating: searchModel.rating,
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
