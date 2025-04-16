import 'package:flutter/material.dart';
import 'package:staff_app/core/utils/constants/colors.dart';

class TTextFormField {
  TTextFormField._();

  static InputDecorationTheme lightTheme = InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: TColors.grey,
      suffixIconColor: TColors.grey,
      // constraints: const BoxConstraints.expand(height: 14, inputFieldHeight),
      labelStyle: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 14, color: TColors.black),
      hintStyle: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 14, color: TColors.black),
      errorStyle: const TextStyle(fontFamily: "Gotham").copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle: const TextStyle(fontFamily: "Gotham").copyWith(color: TColors.black.withOpacity(0.8)),
      border: const OutlineInputBorder()
          .copyWith(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(width: 1, color: TColors.grey)),
      enabledBorder: const OutlineInputBorder()
          .copyWith(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(width: 1, color: TColors.grey)),
      focusedBorder: const OutlineInputBorder()
          .copyWith(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(width: 1, color: Colors.black12)),
      errorBorder: const OutlineInputBorder()
          .copyWith(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(width: 1, color: Colors.red)),
      focusedErrorBorder: const OutlineInputBorder()
          .copyWith(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(width: 1, color: Colors.orange)));

  static InputDecorationTheme darkTheme = InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: TColors.grey,
      suffixIconColor: TColors.grey,
      // constraints: const BoxConstraints.expand(height: 14, inputFieldHeight),
      labelStyle: const TextStyle(fontFamily: "Gotham").copyWith(
        fontSize: 14,
        color: TColors.black,
      ),
      hintStyle: const TextStyle(fontFamily: "Gotham").copyWith(
        fontSize: 14,
        color: TColors.black,
      ),
      errorStyle: const TextStyle(fontFamily: "Gotham").copyWith(
        fontStyle: FontStyle.normal,
      ),
      floatingLabelStyle: const TextStyle(fontFamily: "Gotham").copyWith(color: TColors.black.withOpacity(0.8)),
      border: const OutlineInputBorder()
          .copyWith(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(width: 1, color: TColors.grey)),
      enabledBorder: const OutlineInputBorder()
          .copyWith(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(width: 1, color: TColors.grey)),
      focusedBorder: const OutlineInputBorder()
          .copyWith(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(width: 1, color: TColors.white)),
      errorBorder: const OutlineInputBorder()
          .copyWith(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(width: 1, color: Colors.red)),
      focusedErrorBorder: const OutlineInputBorder()
          .copyWith(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(width: 1, color: Colors.orange)));
}
