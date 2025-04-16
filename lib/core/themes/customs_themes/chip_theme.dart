import 'package:flutter/material.dart';
import 'package:staff_app/core/utils/constants/colors.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightTheme = ChipThemeData(
    disabledColor: TColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(fontFamily: "Gotham", color: TColors.black),
    selectedColor: TColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: TColors.white,
  );
  static ChipThemeData darkTheme = const ChipThemeData(
    disabledColor: TColors.darkerGrey,
    labelStyle: TextStyle(fontFamily: "Gotham", color: TColors.white),
    selectedColor: TColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: TColors.white,
  );
}
