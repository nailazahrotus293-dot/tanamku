import 'package:flutter/material.dart';
import '../data/favorite_store.dart';
import '../theme/app_theme.dart';

class FavoriteButton extends StatelessWidget {
  final String plantId;
  final double size;

  const FavoriteButton({super.key, required this.plantId, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: FavoriteStore.ids,
      builder: (_, ids, __) {
        final fav = ids.contains(plantId);
        return GestureDetector(
          onTap: () => FavoriteStore.toggle(plantId),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
              ],
            ),
            child: Icon(
              fav ? Icons.favorite : Icons.favorite_border,
              size: size,
              color: AppColors.terracotta,
            ),
          ),
        );
      },
    );
  }
}
