import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';
import 'badges.dart';
import 'favorite_button.dart';
import 'plant_image.dart';

/// Kartu tanaman untuk grid / daftar horizontal.
/// Butuh tinggi yang terbatas dari induknya (grid atau SizedBox).
class PlantCard extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const PlantCard({super.key, required this.plant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.sageLight),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(fit: StackFit.expand, children: [
                PlantImage(plant: plant),
                Positioned(
                    top: 8, right: 8, child: FavoriteButton(plantId: plant.id)),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(plant.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                  Text(plant.latinName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 11, color: AppColors.muted)),
                  const SizedBox(height: 6),
                  DifficultyBadge(plant.difficulty),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
