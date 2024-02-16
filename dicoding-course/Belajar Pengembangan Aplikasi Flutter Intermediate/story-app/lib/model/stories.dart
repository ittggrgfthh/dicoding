import 'dart:convert';

class Stories {
  bool error;
  String message;
  List<ListStory> listStory;

  Stories({
    required this.error,
    required this.message,
    required this.listStory,
  });

  Stories copyWith({
    bool? error,
    String? message,
    List<ListStory>? listStory,
  }) =>
      Stories(
        error: error ?? this.error,
        message: message ?? this.message,
        listStory: listStory ?? this.listStory,
      );

  factory Stories.fromRawJson(String str) => Stories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stories.fromJson(Map<String, dynamic> json) => Stories(
        error: json["error"],
        message: json["message"],
        listStory: List<ListStory>.from(json["listStory"].map((x) => ListStory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": List<dynamic>.from(listStory.map((x) => x.toJson())),
      };
}

class ListStory {
  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  double? lat;
  double? lon;

  ListStory({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    this.lat,
    this.lon,
  });

  ListStory copyWith({
    String? id,
    String? name,
    String? description,
    String? photoUrl,
    DateTime? createdAt,
    double? lat,
    double? lon,
  }) =>
      ListStory(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        photoUrl: photoUrl ?? this.photoUrl,
        createdAt: createdAt ?? this.createdAt,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
      );

  factory ListStory.fromRawJson(String str) => ListStory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListStory.fromJson(Map<String, dynamic> json) => ListStory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt.toIso8601String(),
        "lat": lat,
        "lon": lon,
      };
}
