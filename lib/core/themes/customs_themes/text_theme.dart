import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_app/core/utils/constants/colors.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTheme = TextTheme(
    headlineLarge: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 30.0, fontWeight: FontWeight.w800, color: TColors.black),
    headlineMedium: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 20.0, fontWeight: FontWeight.w700, color: TColors.black),
    headlineSmall: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 18.0, fontWeight: FontWeight.w600, color: TColors.black),
    titleLarge: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 17.0, fontWeight: FontWeight.w500, color: TColors.darkerGrey),
    titleMedium: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 17.0, fontWeight: FontWeight.w400, color: TColors.darkerGrey),
    titleSmall: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 17.0, fontWeight: FontWeight.w300, color: TColors.darkerGrey),
    bodyLarge: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 15.0, fontWeight: FontWeight.w500, color: TColors.black),
    bodyMedium: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 15.0, fontWeight: FontWeight.w400, color: TColors.black),
    bodySmall: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 15.0, fontWeight: FontWeight.w300, color: TColors.black),
    labelLarge: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: TColors.black),
    labelMedium: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 12.0, fontWeight: FontWeight.w300, color: TColors.black),
    labelSmall:
        const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 12.0, fontWeight: FontWeight.w300, color: TColors.black.withOpacity(0.5)),
    displaySmall: GoogleFonts.spaceGrotesk(fontSize: 20.0, fontWeight: FontWeight.w500, color: TColors.black),
    displayLarge: GoogleFonts.spaceGrotesk(),
    displayMedium: GoogleFonts.spaceGrotesk(),
  );

  static TextTheme darkTheme = TextTheme(
    headlineLarge: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 30.0, fontWeight: FontWeight.w800, color: Colors.white),
    headlineMedium: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white),
    headlineSmall: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleLarge: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 17.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleMedium: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 17.0, fontWeight: FontWeight.w400, color: Colors.white),
    titleSmall: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 17.0, fontWeight: FontWeight.w300, color: Colors.white),
    bodyLarge: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.white),
    bodyMedium: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.white),
    bodySmall:
        const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.white.withOpacity(0.5)),
    labelLarge: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 14.0, fontWeight: FontWeight.w400, color: TColors.black),
    labelMedium: const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 12.0, fontWeight: FontWeight.w300, color: Colors.white),
    labelSmall:
        const TextStyle(fontFamily: "Gotham").copyWith(fontSize: 12.0, fontWeight: FontWeight.w300, color: Colors.white.withOpacity(0.5)),
    displaySmall: GoogleFonts.spaceGrotesk(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
    displayLarge: GoogleFonts.spaceGrotesk(),
    displayMedium: GoogleFonts.spaceGrotesk(),
  );
}

//
// class TTextTheme {
//   TTextTheme._();
//
//   static TextTheme lightTheme = TextTheme(
//     headlineLarge: GoogleFonts.readexPro(fontSize: 31.0, fontWeight: FontWeight.bold, color:TColors.black),
//     headlineMedium: GoogleFonts.readexPro(fontSize: 21.0, fontWeight: FontWeight.w600, color:TColors.black),
//     headlineSmall: GoogleFonts.readexPro(fontSize: 19.0, fontWeight: FontWeight.w600, color:TColors.black),
//     titleLarge: GoogleFonts.readexPro(fontSize: 18.0, fontWeight: FontWeight.w500, color:TColors.black),
//     titleMedium: GoogleFonts.readexPro(fontSize: 18.0, fontWeight: FontWeight.w400, color:TColors.black),
//     titleSmall: GoogleFonts.readexPro(fontSize: 18.0, fontWeight: FontWeight.w300, color:TColors.black),
//     bodyLarge: GoogleFonts.readexPro(fontSize: 16.0, fontWeight: FontWeight.w500, color:TColors.black),
//     bodyMedium: GoogleFonts.readexPro(fontSize: 16.0, fontWeight: FontWeight.w300, color:TColors.black),
//     bodySmall: GoogleFonts.readexPro(fontSize: 16.0, fontWeight: FontWeight.w300, color:TColors.black.withOpacity(0.5)),
//     labelMedium: GoogleFonts.readexPro(fontSize: 13.0, fontWeight: FontWeight.w300, color:TColors.black),
//     labelSmall: GoogleFonts.readexPro(fontSize: 13.0, fontWeight: FontWeight.w200, color:TColors.black.withOpacity(0.5)),
//   );
//
//   static TextTheme darkTheme = TextTheme(
//     headlineLarge: GoogleFonts.readexPro(fontSize: 31.0, fontWeight: FontWeight.bold, color: Colors.white),
//     headlineMedium: GoogleFonts.readexPro(fontSize: 21.0, fontWeight: FontWeight.w600, color: Colors.white),
//     headlineSmall: GoogleFonts.readexPro(fontSize: 19.0, fontWeight: FontWeight.w600, color: Colors.white),
//     titleLarge: GoogleFonts.readexPro(fontSize: 17.0, fontWeight: FontWeight.w500, color: Colors.white),
//     titleMedium: GoogleFonts.readexPro(fontSize: 17.0, fontWeight: FontWeight.w400, color: Colors.white),
//     titleSmall: GoogleFonts.readexPro(fontSize: 17.0, fontWeight: FontWeight.w300, color: Colors.white),
//     bodyLarge: GoogleFonts.readexPro(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.white),
//     bodyMedium: GoogleFonts.readexPro(fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.white),
//     bodySmall: GoogleFonts.readexPro(fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.white.withOpacity(0.5)),
//     labelMedium: GoogleFonts.readexPro(fontSize: 13.0, fontWeight: FontWeight.w300, color: Colors.white),
//     labelSmall: GoogleFonts.readexPro(fontSize: 13.0, fontWeight: FontWeight.w200, color: Colors.white.withOpacity(0.5)),
//   );
// }
