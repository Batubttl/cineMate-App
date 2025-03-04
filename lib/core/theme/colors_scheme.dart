import 'package:flutter/material.dart';

class AppColors {
  // Ana renkler
  static const Color primaryColor =
      Color(0xFF032541); // TMDB'nin koyu mavi rengi
  static const Color secondaryColor =
      Color(0xFF01B4E4); // TMDB'nin açık mavi rengi
  static const Color accentColor = Color(0xFF90CEA1); // TMDB'nin yeşil rengi

  // Arka plan renkleri
  static const Color scaffoldBackground =
      Color(0xFF1A1A1A); // Koyu tema için arka plan
  static const Color cardBackground = Color(0xFF242424); // Kart arka planı

  // Metin renkleri
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textHint = Colors.white38;

  // Özel renkler
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFFA000);

  // Gradient renkler
  static const List<Color> posterGradient = [
    Colors.transparent,
    Colors.black87,
  ];
}
