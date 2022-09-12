import 'package:flutter/material.dart';
import 'package:proyek2/common/styles.dart';
import 'package:proyek2/widget/card_restaurant_detail.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  const RestaurantDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Restaurant Detail",
        ),
        foregroundColor: foregroundColor,
      ),
      body: const SingleChildScrollView(
        child: CardRestaurantDetail(),
      ),
    );
  }
}
