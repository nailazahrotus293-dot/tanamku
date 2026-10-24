import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/plant.dart';

/// Satu pintu untuk data tanaman. Sekarang membaca JSON lokal;
/// pada tahap berikutnya cukup ganti isi method ini dengan http.get ke API
/// (mis. Perenual atau Trefle) tanpa mengubah halaman.
class PlantRepository {
  Future<List<Plant>> loadPlants() async {
    final raw = await rootBundle.loadString('assets/data/plants.json');
    final list = jsonDecode(raw)['tanaman'] as List;
    return list.map((e) => Plant.fromJson(e as Map<String, dynamic>)).toList();
  }
}
