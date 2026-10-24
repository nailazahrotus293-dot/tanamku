import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';
import '../utils/nav.dart';
import '../widgets/plant_card.dart';

/// Daftar tanaman per kategori, dengan pencarian dan filter tambahan.
class ExplorePage extends StatefulWidget {
  final List<Plant> plants;
  final ValueNotifier<String> category;

  const ExplorePage({super.key, required this.plants, required this.category});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String _query = '';
  String _difficulty = 'Semua';
  String _light = 'Semua';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: widget.category,
      builder: (context, cat, _) {
        final q = _query.toLowerCase();
        final filtered = widget.plants.where((p) {
          final okCat = cat == 'Semua' || p.category == cat;
          final okDiff = _difficulty == 'Semua' || p.difficulty == _difficulty;
          final okLight = _light == 'Semua' || p.light == _light;
          final okQuery = q.isEmpty ||
              p.name.toLowerCase().contains(q) ||
              p.latinName.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q);
          return okCat && okDiff && okLight && okQuery;
        }).toList();

        return Scaffold(
          body: CustomScrollView(slivers: [
            SliverToBoxAdapter(child: _header(context)),
            SliverToBoxAdapter(
              child: _chips(['Semua', ...CategoryStyle.all], cat,
                  (v) => widget.category.value = v),
            ),
            SliverToBoxAdapter(child: _label('Tingkat kesulitan')),
            SliverToBoxAdapter(
              child: _chips(['Semua', 'Mudah', 'Sedang', 'Sulit'], _difficulty,
                  (v) => setState(() => _difficulty = v)),
            ),
            SliverToBoxAdapter(child: _label('Kebutuhan cahaya')),
            SliverToBoxAdapter(
              child: _chips(['Semua', 'Teduh', 'Tidak Langsung', 'Matahari Penuh'], _light,
                  (v) => setState(() => _light = v)),
            ),
            if (filtered.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'Tidak ada tanaman yang cocok.\nCoba ubah kata kunci atau filter.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => PlantCard(
                        plant: filtered[i], onTap: () => openPlant(context, filtered[i])),
                    childCount: filtered.length,
                  ),
                ),
              ),
          ]),
        );
      },
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 18, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.forest,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Jelajah Tanaman',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 14),
        TextField(
          onChanged: (v) => setState(() => _query = v),
          decoration: InputDecoration(
            hintText: 'Cari nama, nama latin, atau kategori',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: AppColors.card,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
      ]),
    );
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 2),
        child: Text(t,
            style: const TextStyle(
                fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.muted)),
      );

  Widget _chips(List<String> options, String selected, ValueChanged<String> onSelect) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final o = options[i];
          final isSel = o == selected;
          return ChoiceChip(
            label: Text(o),
            selected: isSel,
            showCheckmark: false,
            onSelected: (_) => onSelect(o),
            selectedColor: AppColors.forest,
            backgroundColor: AppColors.card,
            side: const BorderSide(color: AppColors.sageLight),
            labelStyle: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: isSel ? Colors.white : AppColors.text,
            ),
          );
        },
      ),
    );
  }
}
