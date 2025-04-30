import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final SharedPreferences _prefs = GetIt.instance<SharedPreferences>();

  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';
  static const _rememberUserKey = 'rem_user';

  Future<void> saveSession(String token, String userId) async {
    await _prefs.setString(_tokenKey, token);
    await _prefs.setString(_userIdKey, userId);
  }

  Future<void> storeUser(bool storeUser) async {
    await _prefs.setBool(_rememberUserKey, storeUser);
  }

  String? getToken() => _prefs.getString(_tokenKey);

  String? getUserId() => _prefs.getString(_userIdKey);

  bool? getIsUserStored() => _prefs.getBool(_rememberUserKey);

  Future<void> clearSession() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userIdKey);
    await _prefs.remove(_rememberUserKey);
  }
}
