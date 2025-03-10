import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTheme = TextTheme(
    headlineLarge: GoogleFonts.readexPro(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: GoogleFonts.readexPro(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
    headlineSmall: GoogleFonts.readexPro(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleLarge: GoogleFonts.readexPro(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleMedium: GoogleFonts.readexPro(fontSize: 17.0, fontWeight: FontWeight.w400, color: Colors.black),
    titleSmall: GoogleFonts.readexPro(fontSize: 17.0, fontWeight: FontWeight.w300, color: Colors.black),
    bodyLarge: GoogleFonts.readexPro(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.black),
    bodyMedium: GoogleFonts.readexPro(fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.black),
    bodySmall: GoogleFonts.readexPro(fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.black.withOpacity(0.5)),
    labelMedium: GoogleFonts.readexPro(fontSize: 12.0, fontWeight: FontWeight.w300, color: Colors.black),
    labelSmall: GoogleFonts.readexPro(fontSize: 12.0, fontWeight: FontWeight.w200, color: Colors.black.withOpacity(0.5)),
    displaySmall: GoogleFonts.spaceGrotesk(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.black),
    displayLarge: GoogleFonts.spaceGrotesk(),
    displayMedium: GoogleFonts.spaceGrotesk(),
  );

  static TextTheme darkTheme = TextTheme(
    headlineLarge: GoogleFonts.readexPro(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: GoogleFonts.readexPro(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: GoogleFonts.readexPro(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleLarge: GoogleFonts.readexPro(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleMedium: GoogleFonts.readexPro(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
    titleSmall: GoogleFonts.readexPro(fontSize: 16.0, fontWeight: FontWeight.w300, color: Colors.white),
    bodyLarge: GoogleFonts.readexPro(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
    bodyMedium: GoogleFonts.readexPro(fontSize: 14.0, fontWeight: FontWeight.w300, color: Colors.white),
    bodySmall: GoogleFonts.readexPro(fontSize: 14.0, fontWeight: FontWeight.w300, color: Colors.white.withOpacity(0.5)),
    labelMedium: GoogleFonts.readexPro(fontSize: 12.0, fontWeight: FontWeight.w300, color: Colors.white),
    labelSmall: GoogleFonts.readexPro(fontSize: 12.0, fontWeight: FontWeight.w200, color: Colors.white.withOpacity(0.5)),
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
//     headlineLarge: GoogleFonts.readexPro(fontSize: 31.0, fontWeight: FontWeight.bold, color: Colors.black),
//     headlineMedium: GoogleFonts.readexPro(fontSize: 21.0, fontWeight: FontWeight.w600, color: Colors.black),
//     headlineSmall: GoogleFonts.readexPro(fontSize: 19.0, fontWeight: FontWeight.w600, color: Colors.black),
//     titleLarge: GoogleFonts.readexPro(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
//     titleMedium: GoogleFonts.readexPro(fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black),
//     titleSmall: GoogleFonts.readexPro(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black),
//     bodyLarge: GoogleFonts.readexPro(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
//     bodyMedium: GoogleFonts.readexPro(fontSize: 16.0, fontWeight: FontWeight.w300, color: Colors.black),
//     bodySmall: GoogleFonts.readexPro(fontSize: 16.0, fontWeight: FontWeight.w300, color: Colors.black.withOpacity(0.5)),
//     labelMedium: GoogleFonts.readexPro(fontSize: 13.0, fontWeight: FontWeight.w300, color: Colors.black),
//     labelSmall: GoogleFonts.readexPro(fontSize: 13.0, fontWeight: FontWeight.w200, color: Colors.black.withOpacity(0.5)),
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
