import 'package:flutter/material.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';

class TCheckboxTheme {
  TCheckboxTheme._();

  static CheckboxThemeData lightTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? Colors.white
            : Colors.black;
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? TColors.primary
            : Colors.transparent;
      }));
  static CheckboxThemeData darkTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? Colors.white
            : Colors.black;
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? TColors.primary
            : Colors.transparent;
      }));
}
