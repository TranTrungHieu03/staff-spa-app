import 'package:flutter/material.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static OutlinedButtonThemeData lightTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    // backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    side: const BorderSide(color: Colors.black),
    textStyle: const TextStyle(fontFamily: "Gotham", fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));
  static OutlinedButtonThemeData darkTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    // elevation: 0,
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    side: const BorderSide(color: Colors.white),
    textStyle: const TextStyle(fontFamily: "Gotham", fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));
}
