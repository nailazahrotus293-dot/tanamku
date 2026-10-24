class Plant {
  final String id;
  final String name;
  final String latinName;
  final String category;
  final String description;
  final String difficulty;
  final String light;
  final String lightInfo;
  final String watering;
  final String humidity;
  final String soil;
  final String placement;
  final bool petSafe;
  final bool popular;
  final List<String> tips;

  const Plant({
    required this.id,
    required this.name,
    required this.latinName,
    required this.category,
    required this.description,
    required this.difficulty,
    required this.light,
    required this.lightInfo,
    required this.watering,
    required this.humidity,
    required this.soil,
    required this.placement,
    required this.petSafe,
    required this.popular,
    required this.tips,
  });

  /// Foto diletakkan di assets/images/<id>.jpg
  String get image => 'assets/images/$id.jpg';

  factory Plant.fromJson(Map<String, dynamic> j) => Plant(
        id: j['id'] as String,
        name: j['nama'] as String,
        latinName: j['nama_latin'] as String,
        category: j['kategori'] as String,
        description: j['deskripsi'] as String,
        difficulty: j['kesulitan'] as String,
        light: j['cahaya'] as String,
        lightInfo: j['cahaya_info'] as String,
        watering: j['siram'] as String,
        humidity: j['kelembapan'] as String,
        soil: j['media'] as String,
        placement: j['penempatan'] as String,
        petSafe: j['aman_hewan'] as bool,
        popular: j['populer'] as bool,
        tips: (j['tips'] as List).map((e) => e as String).toList(),
      );
}
