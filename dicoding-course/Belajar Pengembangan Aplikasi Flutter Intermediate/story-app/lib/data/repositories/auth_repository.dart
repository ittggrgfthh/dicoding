import 'package:http/http.dart' as http;
import 'package:storyapp/data/repositories/preferences_helper.dart';
import '../../model/login.dart';
import '../../model/response_default.dart';
import '../../model/user.dart';

class AuthRepository {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";
  final PreferencesHelper preferencesHelper;

  AuthRepository({required this.preferencesHelper});

  Future<bool> isLoggedIn() async {
    return await preferencesHelper.loginResult == null ? false : true;
  }

  Future<ResponseDefault> register(User user) async {
    final uri = Uri.parse("$_baseUrl/register");
    try {
      final response = await http.post(uri, body: user.toMap());
      return ResponseDefault.fromRawJson(response.body);
    } catch (e) {
      throw Exception('Server Error $e');
    }
  }

  Future<LoginResponse> login(User user) async {
    final uri = Uri.parse("$_baseUrl/login");
    try {
      Map<String, dynamic> request = {
        "email": user.email,
        "password": user.password,
      };

      final response = await http.post(uri, body: request);

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromRawJson(response.body);
        if (loginResponse.loginResult == null) {
          return loginResponse.copyWith(error: true, message: 'Token tidak berhasil didapatkan!');
        }
        preferencesHelper.setLoginResult(loginResponse.loginResult!);
        return loginResponse;
      } else {
        return LoginResponse.fromRawJson(response.body);
      }
    } catch (e) {
      throw Exception('Server Error $e');
    }
  }

  Future<void> logout() async {
    preferencesHelper.setLogout();
  }
}
