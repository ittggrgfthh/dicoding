import 'dart:convert';

class LoginResponse {
  bool error;
  String message;
  LoginResult? loginResult;

  LoginResponse({
    required this.error,
    required this.message,
    this.loginResult,
  });

  LoginResponse copyWith({
    bool? error,
    String? message,
    LoginResult? loginResult,
  }) =>
      LoginResponse(
        error: error ?? this.error,
        message: message ?? this.message,
        loginResult: loginResult ?? this.loginResult,
      );

  factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        error: json["error"],
        message: json["message"],
        loginResult: json["loginResult"] == null ? null : LoginResult.fromJson(json["loginResult"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "loginResult": loginResult?.toJson(),
      };
}

class LoginResult {
  String userId;
  String name;
  String token;

  LoginResult({
    required this.userId,
    required this.name,
    required this.token,
  });

  LoginResult copyWith({
    String? userId,
    String? name,
    String? token,
  }) =>
      LoginResult(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        token: token ?? this.token,
      );

  factory LoginResult.fromRawJson(String str) => LoginResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        userId: json["userId"],
        name: json["name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "token": token,
      };
}
