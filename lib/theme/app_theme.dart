import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palet "earthy sage".
class AppColors {
  static const forest = Color(0xFF2F5D50);
  static const leaf = Color(0xFF4F8A6B);
  static const sage = Color(0xFF8FB996);
  static const sageLight = Color(0xFFDCEBDD);
  static const cream = Color(0xFFF6F3EA);
  static const card = Color(0xFFFFFDF8);
  static const terracotta = Color(0xFFD9825B);
  static const terracottaLight = Color(0xFFF6DCCD);
  static const text = Color(0xFF1F2A24);
  static const muted = Color(0xFF6B7A72);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.forest,
        primary: AppColors.forest,
      ),
      scaffoldBackgroundColor: AppColors.cream,
    );
    return base.copyWith(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme)
          .apply(bodyColor: AppColors.text, displayColor: AppColors.text),
    );
  }
}

/// Ikon dan warna untuk tiap kategori tanaman.
class CategoryStyle {
  static const all = [
    'Daun Hias',
    'Sukulen & Kaktus',
    'Berbunga',
    'Gantung & Rambat',
    'Pembersih Udara',
  ];

  static IconData icon(String category) {
    switch (category) {
      case 'Daun Hias':
        return Icons.eco;
      case 'Sukulen & Kaktus':
        return Icons.spa;
      case 'Berbunga':
        return Icons.local_florist;
      case 'Gantung & Rambat':
        return Icons.grass;
      case 'Pembersih Udara':
        return Icons.air;
      default:
        return Icons.eco;
    }
  }

  static Color color(String category) {
    switch (category) {
      case 'Daun Hias':
        return const Color(0xFFDCEBDD);
      case 'Sukulen & Kaktus':
        return const Color(0xFFE7EFD2);
      case 'Berbunga':
        return const Color(0xFFF6DCCD);
      case 'Gantung & Rambat':
        return const Color(0xFFD3E7DF);
      case 'Pembersih Udara':
        return const Color(0xFFE2ECEF);
      default:
        return AppColors.sageLight;
    }
  }
}
