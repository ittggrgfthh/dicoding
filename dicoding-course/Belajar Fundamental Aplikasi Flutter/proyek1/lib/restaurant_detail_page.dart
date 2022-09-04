import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:proyek1/model/restaurants.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;
  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final ScrollController _foodsController = ScrollController();
  final ScrollController _drinksController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(widget.restaurant.pictureId),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurant.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    RatingBar(
                        initialRating: widget.restaurant.rating.toDouble(),
                        allowHalfRating: true,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: const Icon(Icons.star),
                          half: const Icon(Icons.star_half),
                          empty: const Icon(Icons.star_outline),
                        ),
                        onRatingUpdate: (rating) => print(rating)),
                    Text('Rating : ${widget.restaurant.rating.toString()}'),
                    const Divider(
                      color: Colors.grey,
                    ),
                    ReadMoreText(
                      widget.restaurant.description,
                      trimLines: 3,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: '  Show less',
                      style: const TextStyle(color: Colors.black),
                      moreStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      lessStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                      // delimiter: '...',
                      delimiterStyle: const TextStyle(color: Colors.blue),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    // Foods div
                    const Text(
                      'Foods',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: null,
                    ),
                    Scrollbar(
                      trackVisibility: true,
                      controller: _foodsController,
                      child: SizedBox(
                        height: 140,
                        child: ListView.builder(
                          controller: _foodsController,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.restaurant.foods.length,
                          itemBuilder: ((context, index) {
                            return Container(
                                padding: const EdgeInsets.only(top: 10.0),
                                // color: Colors.blueAccent,
                                width: 140,
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Image.asset('images/image.png')),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        widget.restaurant.foods[index],
                                      ),
                                    ),
                                  ],
                                ));
                          }),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    // Drinks div
                    const Text(
                      'Drinks',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: null,
                    ),
                    Scrollbar(
                      trackVisibility: true,
                      controller: _drinksController,
                      child: SizedBox(
                        height: 140,
                        child: ListView.builder(
                          controller: _drinksController,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.restaurant.drinks.length,
                          itemBuilder: ((context, index) {
                            return Container(
                                padding: const EdgeInsets.only(top: 10.0),
                                // color: Colors.blueAccent,
                                width: 140,
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Image.asset('images/image.png')),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        widget.restaurant.drinks[index],
                                      ),
                                    ),
                                  ],
                                ));
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _foodsController.dispose();
    _drinksController.dispose();
    super.dispose();
  }
}
