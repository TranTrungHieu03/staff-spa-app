import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveData(String key, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  static Future<String> getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<void> removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

class LocalStorageKey {
  static const String userKey = 'my_profile';
  static const String isCompletedOnBoarding = 'is_completed_on_boarding';
  static const String isLogin = 'is_login';
  static const String defaultBranch = 'default_branch';
  static const String branchInfo = 'branch_info';
  static const String isStaff = 'is_staff';
  static const String userChat = 'user_chat';
  static const String staffInfo = 'staff_info';

}
