import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? languageCode = prefs.getString('language_code') ??
          WidgetsBinding.instance.window.locale.languageCode;

      if (languageCode == null || languageCode.isEmpty) {
        languageCode = 'en';
        await prefs.setString('language_code', languageCode);
      }

      _locale = Locale(languageCode);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading language: $e');
    }
  }

  Future<void> changeLanguage(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', locale.languageCode);
      print("change");
      _locale = locale;
      notifyListeners();
    } catch (e) {
      debugPrint('Error changing language: $e');
    }
  }

  String getLanguageName(String code) {
    switch (code) {
      case 'vi':
        return 'Tiếng Việt';
      case 'en':
      default:
        return 'English';
    }
  }
}
