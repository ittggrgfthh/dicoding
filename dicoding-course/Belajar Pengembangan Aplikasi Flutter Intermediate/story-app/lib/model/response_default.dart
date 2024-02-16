import 'dart:convert';

class ResponseDefault {
  final bool error;
  final String message;

  ResponseDefault({
    required this.error,
    required this.message,
  });

  ResponseDefault copyWith({
    bool? error,
    String? message,
  }) =>
      ResponseDefault(
        error: error ?? this.error,
        message: message ?? this.message,
      );

  factory ResponseDefault.fromRawJson(String str) => ResponseDefault.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseDefault.fromJson(Map<String, dynamic> json) => ResponseDefault(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
