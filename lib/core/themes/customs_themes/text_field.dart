
import 'package:flutter/material.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';

class TTextFormField {
  TTextFormField._();

  static InputDecorationTheme lightTheme = InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: TColors.grey,
      suffixIconColor: TColors.grey,
      // constraints: const BoxConstraints.expand(height: 14, inputFieldHeight),
      labelStyle: const TextStyle(fontFamily: 'KumbhSans')
          .copyWith(fontSize: 14, color: TColors.black),
      hintStyle: const TextStyle(fontFamily: 'KumbhSans')
          .copyWith(fontSize: 14, color: TColors.black),
      errorStyle: const TextStyle(fontFamily: 'KumbhSans')
          .copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle:
          const TextStyle().copyWith(color: TColors.black.withOpacity(0.8)),
      border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: TColors.grey)),
      enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: TColors.grey)),
      focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.black12)),
      errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.red)),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.orange)));

  static InputDecorationTheme darkTheme = InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: TColors.grey,
      suffixIconColor: TColors.grey,
      // constraints: const BoxConstraints.expand(height: 14, inputFieldHeight),
      labelStyle: const TextStyle().copyWith(
          fontSize: 14, color: TColors.black, fontFamily: 'KumbhSans'),
      hintStyle: const TextStyle().copyWith(
          fontSize: 14, color: TColors.black, fontFamily: 'KumbhSans'),
      errorStyle: const TextStyle()
          .copyWith(fontStyle: FontStyle.normal, fontFamily: 'KumbhSans'),
      floatingLabelStyle:
          const TextStyle().copyWith(color: TColors.black.withOpacity(0.8)),
      border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: TColors.grey)),
      enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: TColors.grey)),
      focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: TColors.white)),
      errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.red)),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.orange)));
}
