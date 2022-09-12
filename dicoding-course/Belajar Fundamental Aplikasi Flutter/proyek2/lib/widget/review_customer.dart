import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek2/common/styles.dart';
import 'package:proyek2/provider/restaurant_detail_provider.dart';
import 'package:proyek2/widget/error_no_internet.dart';
import 'package:proyek2/widget/modal_add_review.dart';

class ReviewCustomer extends StatefulWidget {
  const ReviewCustomer({super.key});

  @override
  State<ReviewCustomer> createState() => _ReviewCustomerState();
}

class _ReviewCustomerState extends State<ReviewCustomer> {
  @override
  Widget build(BuildContext context) {
    final restaurantDetail = Provider.of<RestaurantDetailProvider>(context);
    final reviews = restaurantDetail.result.restaurant.customerReviews;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "Tanggapan Pelanggan (${reviews.length})",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textForegroundColor),
              ),
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
                child: const Text(
                  'Komentar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: itemForegroundColor,
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: const ModalAddReview()),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: itemForegroundColor,
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        restaurantDetail.state == ResultState.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : restaurantDetail.state == ResultState.noData
                ? const Center(
                    child: Text('Data Kosong!'),
                  )
                : restaurantDetail.state == ResultState.error
                    ? const ErrorNoInternet()
                    : ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: reviews.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            color: itemForegroundColor,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          reviews[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: textForegroundColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 0,
                                        child: Text(
                                          reviews[index].date,
                                          style: const TextStyle(
                                            color: textForegroundColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    reviews[index].review,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
      ],
    );
  }
}
