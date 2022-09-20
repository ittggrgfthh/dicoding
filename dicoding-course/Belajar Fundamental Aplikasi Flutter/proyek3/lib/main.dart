import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:proyek3/common/navigation.dart';
import 'package:proyek3/data/api/add_review_service.dart';
import 'package:proyek3/data/api/restaurant_detail_service.dart';
import 'package:proyek3/data/api/restaurant_list_service.dart';
import 'package:proyek3/data/api/search_service.dart';
import 'package:proyek3/helper/background_service.dart';
import 'package:proyek3/helper/db_favorite.dart';
import 'package:proyek3/helper/notification_helper.dart';
import 'package:proyek3/helper/preferences_helper.dart';
import 'package:proyek3/provider/add_review_provider.dart';
import 'package:proyek3/provider/database_provider.dart';
import 'package:proyek3/provider/preferences_provider.dart';
import 'package:proyek3/provider/restaurant_detail_provider.dart';
import 'package:proyek3/provider/restaurant_list_provider.dart';
import 'package:proyek3/provider/scheduling_provider.dart';
import 'package:proyek3/provider/search_provider.dart';
import 'package:proyek3/ui/restaurant_detail_page.dart';
import 'package:proyek3/ui/home_page.dart';
import 'package:proyek3/common/styles.dart';
import 'package:proyek3/ui/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) => RestaurantListProvider(
              restaurantListService: RestaurantListService()),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
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
        navigatorKey: navigatorKey,
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
