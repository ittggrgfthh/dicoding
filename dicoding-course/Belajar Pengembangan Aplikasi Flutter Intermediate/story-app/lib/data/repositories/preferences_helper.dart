import 'package:shared_preferences/shared_preferences.dart';

import '../../model/login.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const token = 'TOKEN_KEY';
  static const userId = 'USER_ID_KEY';
  static const name = 'NAME_KEY';

  Future<LoginResult?> get loginResult async {
    final prefs = await sharedPreferences;
    if (prefs.getString(token) == null) return null;
    return LoginResult(
      token: prefs.getString(token) ?? '',
      userId: prefs.getString(userId) ?? '',
      name: prefs.getString(name) ?? '',
    );
  }

  void setLoginResult(LoginResult loginResult) async {
    final prefs = await sharedPreferences;
    prefs.setString(token, loginResult.token);
    prefs.setString(userId, loginResult.userId);
    prefs.setString(name, loginResult.name);
  }

  void setLogout() async {
    final prefs = await sharedPreferences;
    prefs.remove(token);
    prefs.remove(userId);
    prefs.remove(name);
  }
}
