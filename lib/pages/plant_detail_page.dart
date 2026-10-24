import 'package:flutter/material.dart';
import '../data/favorite_store.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';
import '../widgets/badges.dart';
import '../widgets/favorite_button.dart';
import '../widgets/plant_image.dart';

class PlantDetailPage extends StatelessWidget {
  final Plant plant;

  const PlantDetailPage({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 320,
          backgroundColor: AppColors.forest,
          automaticallyImplyLeading: false,
          leadingWidth: 64,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back, color: AppColors.forest, size: 20),
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(child: FavoriteButton(plantId: plant.id, size: 20)),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(background: PlantImage(plant: plant)),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(plant.name,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
              Text(plant.latinName,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 14, color: AppColors.muted)),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 8, children: [
                InfoChip(icon: CategoryStyle.icon(plant.category), label: plant.category),
                InfoChip(icon: Icons.home_outlined, label: plant.placement),
                DifficultyBadge(plant.difficulty),
              ]),
              const SizedBox(height: 16),
              Text(plant.description, style: const TextStyle(fontSize: 14, height: 1.6)),
              _heading('Panduan Perawatan'),
              _careTile(Icons.wb_sunny_outlined, 'Cahaya',
                  '${plant.light}. ${plant.lightInfo}'),
              _careTile(Icons.water_drop_outlined, 'Penyiraman', plant.watering),
              _careTile(Icons.cloud_outlined, 'Kelembapan', plant.humidity),
              _careTile(Icons.landscape_outlined, 'Media tanam', plant.soil),
              _heading('Tips Perawatan'),
              ...List.generate(plant.tips.length, (i) => _tip(i + 1, plant.tips[i])),
              const SizedBox(height: 16),
              _petBanner(),
            ]),
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        color: AppColors.cream,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: ValueListenableBuilder<Set<String>>(
              valueListenable: FavoriteStore.ids,
              builder: (_, ids, __) {
                final fav = ids.contains(plant.id);
                return FilledButton.icon(
                  onPressed: () => FavoriteStore.toggle(plant.id),
                  icon: Icon(fav ? Icons.favorite : Icons.favorite_border),
                  label: Text(fav ? 'Hapus dari Favorit' : 'Tambah ke Favorit'),
                  style: FilledButton.styleFrom(
                    backgroundColor: fav ? AppColors.terracotta : AppColors.forest,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _heading(String t) => Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 10),
        child: Text(t, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
      );

  Widget _careTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.sageLight),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: const BoxDecoration(color: AppColors.sageLight, shape: BoxShape.circle),
          child: Icon(icon, size: 20, color: AppColors.forest),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.muted)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 13.5, height: 1.45)),
          ]),
        ),
      ]),
    );
  }

  Widget _tip(int n, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: AppColors.forest,
          child: Text('$n', style: const TextStyle(color: Colors.white, fontSize: 11.5)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13.5, height: 1.5))),
      ]),
    );
  }

  Widget _petBanner() {
    final safe = plant.petSafe;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: safe ? AppColors.sageLight : AppColors.terracottaLight,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(children: [
        Icon(safe ? Icons.pets : Icons.warning_amber_rounded,
            color: safe ? AppColors.forest : AppColors.terracotta),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            safe
                ? 'Umumnya aman untuk hewan peliharaan.'
                : 'Bisa beracun jika tertelan. Letakkan jauh dari jangkauan hewan peliharaan dan anak kecil.',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, height: 1.4),
          ),
        ),
      ]),
    );
  }
}
