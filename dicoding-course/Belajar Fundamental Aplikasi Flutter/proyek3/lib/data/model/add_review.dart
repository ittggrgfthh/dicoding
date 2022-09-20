class AddReviewModel {
  AddReviewModel({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  bool error;
  String message;
  List<AddCustomerReview> customerReviews;

  factory AddReviewModel.fromJson(Map<String, dynamic> json) => AddReviewModel(
        error: json["error"],
        message: json["message"],
        customerReviews: List<AddCustomerReview>.from(
            json["customerReviews"].map((x) => AddCustomerReview.fromJson(x))),
      );
}

class AddCustomerReview {
  AddCustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  String name;
  String review;
  String date;

  factory AddCustomerReview.fromJson(Map<String, dynamic> json) =>
      AddCustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );
}
