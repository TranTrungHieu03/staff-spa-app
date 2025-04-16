import 'package:flutter/material.dart';
import 'package:staff_app/core/utils/constants/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: TColors.primary,
    disabledForegroundColor: Colors.grey,
    disabledBackgroundColor: Colors.grey,
    side: const BorderSide(color: Colors.transparent),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    textStyle: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));
  static final darkTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: TColors.primary,
    disabledForegroundColor: Colors.grey,
    disabledBackgroundColor: Colors.grey,
    side: const BorderSide(color: Colors.transparent),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    textStyle: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));
}
