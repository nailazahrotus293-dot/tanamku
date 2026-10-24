import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';
import 'badges.dart';
import 'favorite_button.dart';
import 'plant_image.dart';

/// Baris tanaman (foto kecil + nama + label kesulitan).
class PlantListTile extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const PlantListTile({super.key, required this.plant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Material(
        color: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.sageLight),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(width: 62, height: 62, child: PlantImage(plant: plant)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(plant.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  Text(plant.latinName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 11.5, color: AppColors.muted)),
                  const SizedBox(height: 6),
                  Row(children: [
                    DifficultyBadge(plant.difficulty),
                    const SizedBox(width: 6),
                    Text(plant.light,
                        style: const TextStyle(fontSize: 11, color: AppColors.muted)),
                  ]),
                ]),
              ),
              FavoriteButton(plantId: plant.id),
            ]),
          ),
        ),
      ),
    );
  }
}
