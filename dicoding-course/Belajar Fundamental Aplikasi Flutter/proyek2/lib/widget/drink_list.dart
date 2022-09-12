import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek2/common/styles.dart';
import 'package:proyek2/provider/restaurant_detail_provider.dart';
import 'package:proyek2/widget/error_no_internet.dart';

class DrinkList extends StatefulWidget {
  const DrinkList({super.key});

  @override
  State<DrinkList> createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  final ScrollController drinksController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final restaurantDetail = Provider.of<RestaurantDetailProvider>(context);
    final drinkList = restaurantDetail.result.restaurant.menus.drinks;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Daftar Minuman (${drinkList.length})",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Scrollbar(
          trackVisibility: true,
          controller: drinksController,
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
                            controller: drinksController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: drinkList.length,
                            itemBuilder: ((context, index) {
                              return Container(
                                padding: const EdgeInsets.only(top: 10.0),
                                width: 140,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Image.asset(
                                        'images/drink_not_found.jpg',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        drinkList[index].name,
                                        style: const TextStyle(
                                          color: textForegroundColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    drinksController.dispose();
    super.dispose();
  }
}
