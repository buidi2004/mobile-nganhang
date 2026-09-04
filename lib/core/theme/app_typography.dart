import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextStyle displayLarge({Color? color}) => GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: -0.5,
      );

  static TextStyle displayMedium({Color? color}) => GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static TextStyle displaySmall({Color? color}) => GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle titleLarge({Color? color}) => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle titleMedium({Color? color}) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle bodyLarge({Color? color}) => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle bodySmall({Color? color}) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle labelLarge({Color? color}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle balanceText({Color? color}) => GoogleFonts.outfit(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: color,
      );
}
