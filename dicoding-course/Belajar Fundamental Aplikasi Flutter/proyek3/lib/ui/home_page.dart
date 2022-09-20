import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyek3/ui/favorite_page.dart';
import 'package:proyek3/ui/restaurant_list_page.dart';
import 'package:proyek3/widget/platform_widget.dart';
import 'package:proyek3/ui/settings_page.dart';
import 'package:proyek3/common/styles.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomNavIndex = 0;
  static const String _restaurantText = 'Restaurants';

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu),
      label: _restaurantText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: FavoritePage.favoritesTitle,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: SettingsPage.settingsTitle,
    ),
  ];

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const FavoritePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        selectedItemColor: foregroundColor,
        currentIndex: bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) => setState(() => bottomNavIndex = selected),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: backgroundColor,
        items: _bottomNavBarItems,
      ),
      tabBuilder: ((context, index) {
        return _listWidget[index];
      }),
    );
  }
}
