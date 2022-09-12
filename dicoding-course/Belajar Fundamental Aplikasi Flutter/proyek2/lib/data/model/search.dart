class SearchModel {
  SearchModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<SearchRestaurant> restaurants;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<SearchRestaurant>.from(
            json["restaurants"].map((x) => SearchRestaurant.fromJson(x))),
      );
}

class SearchRestaurant {
  SearchRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) =>
      SearchRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );
}
