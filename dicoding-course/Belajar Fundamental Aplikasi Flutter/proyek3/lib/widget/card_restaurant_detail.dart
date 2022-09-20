import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek3/common/styles.dart';
import 'package:proyek3/provider/restaurant_detail_provider.dart';
import 'package:proyek3/widget/drink_list.dart';
import 'package:proyek3/widget/food_list.dart';
import 'package:proyek3/widget/review_customer.dart';
import 'package:readmore/readmore.dart';

class CardRestaurantDetail extends StatelessWidget {
  const CardRestaurantDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantDetail = Provider.of<RestaurantDetailProvider>(context);
    final pictureId = restaurantDetail.result.restaurant.pictureId;
    const pictureSize = 'medium/';
    const urlToImage = 'https://restaurant-api.dicoding.dev/images/';
    return Column(
      children: [
        Hero(
          tag: urlToImage + pictureSize + pictureId,
          child: Image.network(
            urlToImage + pictureSize + pictureId,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurantDetail.result.restaurant.name,
                style: const TextStyle(
                  color: textForegroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 0,
                    child: Icon(
                      Icons.location_on_sharp,
                      color: textForegroundColor,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "${restaurantDetail.result.restaurant.city}, ${restaurantDetail.result.restaurant.address}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: textForegroundColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 0,
                    child: Icon(
                      Icons.star_purple500_sharp,
                      color: textForegroundColor,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      restaurantDetail.result.restaurant.rating.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: textForegroundColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(color: itemForegroundColor),
              ReadMoreText(
                restaurantDetail.result.restaurant.description,
                trimLines: 3,
                trimMode: TrimMode.Line,
                lessStyle: const TextStyle(
                  color: textForegroundColor,
                  fontWeight: FontWeight.bold,
                ),
                trimExpandedText: " tutup",
                trimCollapsedText: "baca lebih lanjut",
                moreStyle: const TextStyle(
                  color: textForegroundColor,
                  fontWeight: FontWeight.bold,
                ),
                style: const TextStyle(
                  color: textForegroundColor,
                  fontSize: 14,
                ),
              ),
              const Divider(color: itemForegroundColor),
              const SizedBox(height: 10),
              const FoodList(),
              const Divider(color: itemForegroundColor),
              const DrinkList(),
              const Divider(color: itemForegroundColor),
              const ReviewCustomer(),
            ],
          ),
        ),
      ],
    );
  }
}
