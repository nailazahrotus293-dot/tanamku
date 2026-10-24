import 'package:flutter/material.dart';
import '../models/plant.dart';

void openPlant(BuildContext context, Plant plant) {
  Navigator.pushNamed(context, '/detail', arguments: plant);
}
