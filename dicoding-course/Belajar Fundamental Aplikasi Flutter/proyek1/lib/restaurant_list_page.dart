import 'package:flutter/material.dart';
import 'package:proyek1/model/restaurants.dart';
import 'package:proyek1/restaurant_detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';
  final RestaurantRepository restaurantList = RestaurantRepository();
  RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: FutureBuilder(
        future: restaurantList.readJson(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: restaurantList.restaurantList.length,
            itemBuilder: ((context, index) => _buildRestaurantItem(
                context, restaurantList.restaurantList.toList()[index])),
          );
        }),
      ),
    );
  }

  _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(restaurant.pictureId),
        radius: 30,
      ),
      isThreeLine: true,
      title: Expanded(
        child: Text(
          restaurant.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Flexible(child: Icon(Icons.location_on)),
                Expanded(flex: 1, child: Text(restaurant.city)),
              ],
            ),
            Row(
              children: [
                const Flexible(child: Icon(Icons.star)),
                Expanded(flex: 1, child: Text(restaurant.rating.toString())),
              ],
            ),
          ],
        ),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        RestaurantDetailPage.routeName,
        arguments: restaurant,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.keyboard_arrow_right_rounded),
        ],
      ),
    );
  }
}
