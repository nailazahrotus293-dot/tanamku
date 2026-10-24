import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';

/// Menampilkan foto dari assets/images. Jika foto belum ada,
/// tampil ilustrasi sementara sesuai kategori.
class PlantImage extends StatelessWidget {
  final Plant plant;
  final BoxFit fit;

  const PlantImage({super.key, required this.plant, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      plant.image,
      fit: fit,
      errorBuilder: (_, __, ___) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [CategoryStyle.color(plant.category), AppColors.sage.withOpacity(0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Icon(CategoryStyle.icon(plant.category),
              size: 48, color: AppColors.forest.withOpacity(0.55)),
        ),
      ),
    );
  }
}
