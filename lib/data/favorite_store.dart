import 'package:flutter/foundation.dart';

/// Penyimpanan favorit sederhana (in-memory).
class FavoriteStore {
  static final ValueNotifier<Set<String>> ids = ValueNotifier<Set<String>>({});

  static bool isFavorite(String id) => ids.value.contains(id);

  static void toggle(String id) {
    final next = {...ids.value};
    if (!next.remove(id)) next.add(id);
    ids.value = next;
  }
}
