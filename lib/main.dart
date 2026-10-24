import 'package:flutter/material.dart';
import 'models/plant.dart';
import 'pages/main_shell.dart';
import 'pages/plant_detail_page.dart';
import 'theme/app_theme.dart';

void main() => runApp(const TanamkuApp());

class TanamkuApp extends StatelessWidget {
  const TanamkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tanamku',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/detail':
            final plant = settings.arguments as Plant;
            return MaterialPageRoute(builder: (_) => PlantDetailPage(plant: plant));
          default:
            return MaterialPageRoute(builder: (_) => const MainShell());
        }
      },
    );
  }
}
