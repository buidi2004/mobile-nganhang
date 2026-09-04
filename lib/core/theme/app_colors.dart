import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Sen Hồng Brand Palette (Chuyển sang Tone Xanh Ngọc Lam / Cyan Oceanic)
  static const Color primary = Color(0xFF0096C7);
  static const Color primaryDark = Color(0xFF0077B6);
  static const Color primaryLight = Color(0xFF48CAE4);
  static const Color primaryAccent = Color(0xFF26E5DC);
  static const Color accentGold = Color(0xFFFFB300);

  // Secondary & Accents
  static const Color emeraldGreen = Color(0xFF10B981);
  static const Color vividTeal = Color(0xFF00BFA5);
  static const Color softPurple = Color(0xFF8B5CF6);
  static const Color oceanBlue = Color(0xFF0288D1);

  // Light Mode Surfaces (Chủ đạo theo yêu cầu người dùng)
  static const Color bgLight = Color(0xFFF6F9FC);
  static const Color bgSurfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardBorderLight = Color(0xFFE2E8F0);

  // Backgrounds & Surface (Dark Mode Fintech)
  static const Color bgDark = Color(0xFF0B0E17);
  static const Color bgSurfaceDark = Color(0xFF131929);
  static const Color cardDark = Color(0xFF1A2238);
  static const Color cardBorderDark = Color(0x33FFFFFF);

  // Glassmorphism Tint Colors
  static const Color glassFillLight = Color(0xB8FFFFFF);
  static const Color glassBorderLight = Color(0x80FFFFFF);
  static const Color glassFillDark = Color(0x2A1E293B);
  static const Color glassBorderDark = Color(0x3DFFFFFF);

  // State & Status
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF0096C7);

  // Text Colors (Light Mode)
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textMutedLight = Color(0xFF94A3B8);

  // Text Colors (Dark Mode)
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF26E5DC), Color(0xFF0096C7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient balanceCardGradient = LinearGradient(
    colors: [
      Color(0xFF023E8A),
      Color(0xFF0077B6),
      Color(0xFF0096C7),
      Color(0xFF26E5DC),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGoldGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706), Color(0xFFB45309)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardTitaniumGradient = LinearGradient(
    colors: [Color(0xFF334155), Color(0xFF1E293B), Color(0xFF0F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
