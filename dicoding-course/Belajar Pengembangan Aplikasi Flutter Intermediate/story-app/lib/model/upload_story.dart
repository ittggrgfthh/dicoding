import 'dart:convert';

class UploadStory {
  String description;
  String fileName;
  List<int> bytes;

  UploadStory({
    required this.description,
    required this.fileName,
    required this.bytes,
  });

  UploadStory copyWith({
    String? description,
    String? fileName,
    List<int>? bytes,
  }) =>
      UploadStory(
        description: description ?? this.description,
        fileName: fileName ?? this.fileName,
        bytes: bytes ?? this.bytes,
      );

  factory UploadStory.fromRawJson(String str) => UploadStory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UploadStory.fromJson(Map<String, dynamic> json) => UploadStory(
        description: json["description"],
        fileName: json["fileName"],
        bytes: List<int>.from(json["bytes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "fileName": fileName,
        "bytes": List<dynamic>.from(bytes.map((x) => x)),
      };
}
