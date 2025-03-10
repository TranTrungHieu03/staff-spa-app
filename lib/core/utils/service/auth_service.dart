import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff_app/core/logger/logger.dart';

class AuthService {
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    AppLogger.info("Remove token");
    await prefs.remove('auth_token');
  }
}
