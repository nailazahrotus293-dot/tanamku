import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Label tingkat kesulitan: hijau (mudah), kuning (sedang), terracotta (sulit).
class DifficultyBadge extends StatelessWidget {
  final String difficulty;

  const DifficultyBadge(this.difficulty, {super.key});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    switch (difficulty) {
      case 'Mudah':
        bg = AppColors.sageLight;
        fg = AppColors.forest;
        break;
      case 'Sedang':
        bg = const Color(0xFFFFF1D6);
        fg = const Color(0xFF8A6100);
        break;
      default:
        bg = AppColors.terracottaLight;
        fg = const Color(0xFFB5532A);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(difficulty,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg)),
    );
  }
}

/// Chip informasi kecil dengan ikon.
class InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoChip({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.sageLight),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: AppColors.forest),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}
