import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyek2/data/api/restaurant_list_service.dart';
import 'package:proyek2/provider/restaurant_list_provider.dart';
import 'package:proyek2/ui/restaurant_list_page.dart';
import 'package:proyek2/widget/platform_widget.dart';
import 'package:proyek2/ui/settings_page.dart';
import 'package:proyek2/common/styles.dart';
import 'package:provider/provider.dart';

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
      icon: Icon(Icons.settings),
      label: SettingsPage.settingsTitle,
    ),
  ];

  final List<Widget> _listWidget = [
    ChangeNotifierProvider(
      create: (_) => RestaurantListProvider(
        restaurantListService: RestaurantListService(),
      ),
      child: const RestaurantListPage(),
    ),
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
