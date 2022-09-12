import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek2/common/styles.dart';
import 'package:proyek2/provider/add_review_provider.dart';
import 'package:proyek2/provider/restaurant_detail_provider.dart';

class ModalAddReview extends StatelessWidget {
  const ModalAddReview({super.key});

  @override
  Widget build(BuildContext context) {
    AddReviewProvider addReviewProvider =
        Provider.of<AddReviewProvider>(context);
    final restaurantDetail = Provider.of<RestaurantDetailProvider>(context);
    return SingleChildScrollView(
      child: Container(
        height: 400,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Tambah Komentar",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: textForegroundColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Nama : ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textForegroundColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  cursorColor: textForegroundColor,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: foregroundColor,
                    hintText: "Isi namamu",
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: (value) => addReviewProvider.setName(value),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Komentar :",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textForegroundColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  cursorColor: textForegroundColor,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: foregroundColor,
                    hintText: "Tambahkan pengalaman anda tentang restoran ini",
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: (value) => addReviewProvider.setReview(value),
                ),
              ],
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(height: 35),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  final String id = restaurantDetail.result.restaurant.id;
                  addReviewProvider.submitReview(id);
                  restaurantDetail.setRestaurantDetail(restaurantDetail.result);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: itemForegroundColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
