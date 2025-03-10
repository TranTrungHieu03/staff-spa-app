import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff_app/core/logger/logger.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('vi');

  Locale get locale => _locale;

  Future<void> loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? languageCode = prefs.getString('language_code') ?? WidgetsBinding.instance.window.locale.languageCode;

      AppLogger.info('Language code: $languageCode');
      if (languageCode.isEmpty) {
        languageCode = 'vi';
        await prefs.setString('language_code', languageCode);
      }

      _locale = Locale(languageCode);
      notifyListeners();
    } catch (e) {
      AppLogger.info('Error loading language: $e');
    }
  }

  Future<void> changeLanguage(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', locale.languageCode);
      _locale = locale;
      notifyListeners();
    } catch (e) {
      AppLogger.info('Error changing language: $e');
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

  String getCurrentLanguageName() {
    return getLanguageName(_locale.languageCode);
  }

  String getCurrentLanguageCode() {
    return _locale.languageCode;
  }
}
