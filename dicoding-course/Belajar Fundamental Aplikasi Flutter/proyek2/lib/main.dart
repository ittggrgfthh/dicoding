import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek2/data/api/add_review_service.dart';
import 'package:proyek2/data/api/restaurant_detail_service.dart';
import 'package:proyek2/data/api/search_service.dart';
import 'package:proyek2/provider/add_review_provider.dart';
import 'package:proyek2/provider/restaurant_detail_provider.dart';
import 'package:proyek2/provider/search_provider.dart';
import 'package:proyek2/ui/restaurant_detail_page.dart';
import 'package:proyek2/ui/home_page.dart';
import 'package:proyek2/common/styles.dart';
import 'package:proyek2/ui/search_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(
              restaurantDetailService: RestaurantDetailService()),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(searchService: SearchService()),
        ),
        ChangeNotifierProvider<AddReviewProvider>(
          create: (_) =>
              AddReviewProvider(addReviewService: AddReviewService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: backgroundColor,
                onPrimary: Colors.black,
                secondary: foregroundColor,
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              textStyle: const TextStyle(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
            ),
          ),
          scaffoldBackgroundColor: foregroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          RestaurantDetailPage.routeName: (context) =>
              const RestaurantDetailPage(),
          SearchPage.routeName: (context) => const SearchPage(),
        },
      ),
    );
  }
}
