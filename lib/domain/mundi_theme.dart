import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MundiTheme {
  static TextTheme textTheme = TextTheme(
    bodyLarge: GoogleFonts.kalam(
        fontSize: 20, fontWeight: FontWeight.normal, color: const Color(0xFFf5f5f5)),
    bodyMedium: GoogleFonts.kalam(
        fontSize: 18, fontWeight: FontWeight.normal, color: const Color(0xFF006400)),
    headlineLarge: GoogleFonts.kosugiMaru(
        fontSize: 60, fontWeight: FontWeight.bold, color: Colors.green[800]),
    headlineMedium: GoogleFonts.kosugiMaru(
        fontSize: 30, fontWeight: FontWeight.normal, color: Colors.brown),
    headlineSmall: GoogleFonts.kosugiMaru(
        fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white70),
  );

}