import 'dart:ui';

import 'package:flutter/material.dart';

Color getProgressColor(double value) {
  if (value < 0.5) return Colors.red;
  if (value < 0.7) return Colors.orange;
  if (value < 1) return const Color.fromARGB(255, 105, 176, 209);
  return Colors.green;
}
