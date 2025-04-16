import 'package:flutter/material.dart';
import 'package:staff_app/core/utils/constants/colors.dart';

class TTextButtonTheme {
  TTextButtonTheme._();

  static final lightTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: TColors.primary,
      // Màu chữ khi enabled
      disabledForegroundColor: Colors.grey,
      // Màu chữ khi disabled
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      // Padding
      textStyle: const TextStyle(
        fontFamily: "Gotham",
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      // Kiểu chữ
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Bo góc
      ),
    ),
  );

  static final darkTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: TColors.primary,
      // Màu chữ khi enabled
      disabledForegroundColor: Colors.grey,
      // Màu chữ khi disabled
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      // Padding
      textStyle: const TextStyle(
        fontFamily: "Gotham",
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      // Kiểu chữ
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Bo góc
      ),
    ),
  );
}
