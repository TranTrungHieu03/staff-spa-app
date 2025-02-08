import 'package:flutter/material.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
class TBottomSheetTheme {
  TBottomSheetTheme._();

  static BottomSheetThemeData lightTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: Colors.white,
      modalBackgroundColor: Colors.white,
      constraints: const BoxConstraints(minWidth: double.infinity),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));

  static BottomSheetThemeData darkTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: TColors.black,
      modalBackgroundColor: TColors.black,
      constraints: const BoxConstraints(minWidth: double.infinity),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
}
