import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek3/common/styles.dart';
import 'package:proyek3/provider/restaurant_detail_provider.dart';
import 'package:proyek3/widget/error_no_internet.dart';

class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  final ScrollController foodsController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final restaurantDetail = Provider.of<RestaurantDetailProvider>(context);
    final foodList = restaurantDetail.result.restaurant.menus.foods;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Daftar Makanan (${foodList.length})",
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textForegroundColor),
        ),
        Scrollbar(
          trackVisibility: true,
          controller: foodsController,
          child: SizedBox(
            height: 140,
            child: restaurantDetail.state == ResultState.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : restaurantDetail.state == ResultState.noData
                    ? const Center(
                        child: Text('Data Kosong!'),
                      )
                    : restaurantDetail.state == ResultState.error
                        ? const ErrorNoInternet()
                        : ListView.builder(
                            controller: foodsController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: foodList.length,
                            itemBuilder: ((context, index) {
                              return Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  width: 140,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Image.asset(
                                          'images/food_not_found.webp',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          foodList[index].name,
                                          style: const TextStyle(
                                            color: textForegroundColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                            }),
                          ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    foodsController.dispose();
    super.dispose();
  }
}
