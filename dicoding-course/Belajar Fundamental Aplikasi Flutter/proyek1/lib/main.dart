import 'package:flutter/material.dart';
import 'package:proyek1/restaurant_detail_page.dart';
import 'package:proyek1/model/restaurants.dart';
import 'package:proyek1/restaurant_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Restaurant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: RestaurantListPage.routeName,
        debugShowCheckedModeBanner: false,
        routes: {
          RestaurantListPage.routeName: (context) => RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
        });
  }
}
