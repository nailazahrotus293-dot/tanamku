import 'package:flutter/material.dart';
import '../data/favorite_store.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';
import '../utils/nav.dart';
import '../widgets/plant_card.dart';
import '../widgets/plant_image.dart';
import '../widgets/plant_list_tile.dart';

class HomePage extends StatelessWidget {
  final List<Plant> plants;
  final ValueChanged<String> onCategoryTap;
  final VoidCallback onSearchTap;
  final VoidCallback onFavoriteTap;

  const HomePage({
    super.key,
    required this.plants,
    required this.onCategoryTap,
    required this.onSearchTap,
    required this.onFavoriteTap,
  });

  static const _tips = [
    'Siram tanaman di pagi hari agar air terserap sebelum cuaca panas.',
    'Cek kelembapan tanah dengan jari sebelum menyiram, jangan menyiram berdasarkan jadwal saja.',
    'Putar pot setiap beberapa minggu supaya tanaman tumbuh rata ke semua arah.',
    'Bersihkan debu pada daun agar tanaman bisa menyerap cahaya dengan baik.',
    'Pot tanpa lubang drainase adalah penyebab utama akar busuk.',
  ];

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 11) return 'Selamat pagi';
    if (h < 15) return 'Selamat siang';
    if (h < 18) return 'Selamat sore';
    return 'Selamat malam';
  }

  @override
  Widget build(BuildContext context) {
    final dayOfYear =
        DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    final today = plants[dayOfYear % plants.length];
    final tip = _tips[dayOfYear % _tips.length];
    final popular = plants.where((p) => p.popular).toList();
    final beginners = plants.where((p) => p.difficulty == 'Mudah').take(4).toList();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _header(context),
        _title('Kategori'),
        _categories(),
        _favorites(context),
        _title('Tanaman Hari Ini'),
        _todayCard(context, today),
        _title('Tanaman Populer'),
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: popular.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => SizedBox(
              width: 160,
              child: PlantCard(plant: popular[i], onTap: () => openPlant(context, popular[i])),
            ),
          ),
        ),
        _title('Cocok untuk Pemula'),
        ...beginners.map((p) => PlantListTile(plant: p, onTap: () => openPlant(context, p))),
        _tipCard(tip),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 18, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.forest, AppColors.leaf],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(_greeting(),
                    style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                const SizedBox(height: 2),
                const Text('Mau rawat tanaman apa hari ini?',
                    style: TextStyle(
                        color: Colors.white, fontSize: 19, fontWeight: FontWeight.w700)),
              ]),
            ),
            ValueListenableBuilder<Set<String>>(
              valueListenable: FavoriteStore.ids,
              builder: (_, ids, __) => GestureDetector(
                onTap: onFavoriteTap,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.16), shape: BoxShape.circle),
                  child: Badge(
                    label: Text('${ids.length}'),
                    isLabelVisible: ids.isNotEmpty,
                    backgroundColor: AppColors.terracotta,
                    child: const Icon(Icons.favorite_border, color: Colors.white),
                  ),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 18),
          GestureDetector(
            onTap: onSearchTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(16)),
              child: const Row(children: [
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 10),
                Text('Cari nama tanaman...', style: TextStyle(color: Colors.white70)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categories() {
    return SizedBox(
      height: 112,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: CategoryStyle.all.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final c = CategoryStyle.all[i];
          return GestureDetector(
            onTap: () => onCategoryTap(c),
            child: Container(
              width: 98,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CategoryStyle.color(c),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.white54, shape: BoxShape.circle),
                    child: Icon(CategoryStyle.icon(c), color: AppColors.forest, size: 20),
                  ),
                  Text(c,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Bagian "Favoritku": hanya muncul kalau sudah ada tanaman favorit.
  Widget _favorites(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: FavoriteStore.ids,
      builder: (_, ids, __) {
        final favs = plants.where((p) => ids.contains(p.id)).toList();
        if (favs.isEmpty) return const SizedBox.shrink();
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _title('Favoritku'),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: favs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) => SizedBox(
                width: 140,
                child: PlantCard(plant: favs[i], onTap: () => openPlant(context, favs[i])),
              ),
            ),
          ),
        ]);
      },
    );
  }

  Widget _todayCard(BuildContext context, Plant p) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: AppColors.sageLight),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => openPlant(context, p),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(width: 104, height: 104, child: PlantImage(plant: p)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('PILIHAN HARI INI',
                      style: TextStyle(
                          fontSize: 10.5,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w700,
                          color: AppColors.terracotta)),
                  const SizedBox(height: 4),
                  Text(p.name,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                  Text(p.latinName,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 11.5, color: AppColors.muted)),
                  const SizedBox(height: 6),
                  Text(p.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, height: 1.4)),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _tipCard(String tip) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.terracottaLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.lightbulb_outline, color: AppColors.terracotta),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Tips Perawatan',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 4),
            Text(tip, style: const TextStyle(fontSize: 12.5, height: 1.45)),
          ]),
        ),
      ]),
    );
  }

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
        child: Text(t, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800)),
      );
}
