import 'package:flutter/material.dart';
import '../data/favorite_store.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';
import '../utils/nav.dart';
import '../widgets/plant_card.dart';

class FavoritePage extends StatelessWidget {
  final List<Plant> plants;

  const FavoritePage({super.key, required this.plants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.forest,
        foregroundColor: Colors.white,
        title: const Text('Tanaman Favorit',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: FavoriteStore.ids,
        builder: (_, ids, __) {
          final favs = plants.where((p) => ids.contains(p.id)).toList();
          if (favs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.favorite_border, size: 56, color: AppColors.sage),
                  SizedBox(height: 12),
                  Text('Belum ada favorit',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  SizedBox(height: 4),
                  Text('Tekan ikon hati pada tanaman yang kamu suka,\nlalu tanamannya muncul di sini.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.muted)),
                ]),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: favs.length,
            itemBuilder: (_, i) =>
                PlantCard(plant: favs[i], onTap: () => openPlant(context, favs[i])),
          );
        },
      ),
    );
  }
}
