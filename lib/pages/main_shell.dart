import 'package:flutter/material.dart';
import '../data/plant_repository.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';
import 'explore_page.dart';
import 'favorite_page.dart';
import 'home_page.dart';

/// Kerangka utama: BottomNavigationBar (Beranda, Jelajah, Favorit).
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late final Future<List<Plant>> _future;
  final ValueNotifier<String> _category = ValueNotifier<String>('Semua');
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _future = PlantRepository().loadPlants();
  }

  @override
  void dispose() {
    _category.dispose();
    super.dispose();
  }

  void _goTo(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plant>>(
      future: _future,
      builder: (context, snap) {
        if (snap.hasError) {
          return Scaffold(body: Center(child: Text('Gagal memuat data: ${snap.error}')));
        }
        if (!snap.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final plants = snap.data!;
        return Scaffold(
          body: IndexedStack(index: _index, children: [
            HomePage(
              plants: plants,
              onCategoryTap: (c) {
                _category.value = c;
                _goTo(1);
              },
              onSearchTap: () => _goTo(1),
              onFavoriteTap: () => _goTo(2),
            ),
            ExplorePage(plants: plants, category: _category),
            FavoritePage(plants: plants),
          ]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: _goTo,
            selectedItemColor: AppColors.forest,
            unselectedItemColor: AppColors.muted,
            backgroundColor: AppColors.card,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Beranda'),
              BottomNavigationBarItem(icon: Icon(Icons.explore_rounded), label: 'Jelajah'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: 'Favorit'),
            ],
          ),
        );
      },
    );
  }
}
