import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/ui/article_list_page.dart';
import 'package:news_app/widget/platform_widget.dart';
import 'package:news_app/ui/settings_page.dart';
import 'package:news_app/common/styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomNavIndex = 0;
  static const String _headlineText = 'Headline';

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.public),
      label: _headlineText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: SettingsPage.settingsTitle,
    ),
  ];

  final List<Widget> _listWidget = [
    ChangeNotifierProvider(
        create: (_) => NewsProvider(apiService: ApiService()),
        child: const ArticleListPage()),
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
        selectedItemColor: secondaryColor,
        currentIndex: bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) => setState(() => bottomNavIndex = selected),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: secondaryColor,
        items: _bottomNavBarItems,
      ),
      tabBuilder: ((context, index) {
        return _listWidget[index];
      }),
    );
  }
}
