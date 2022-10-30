
import 'dart:math';

import 'package:flutter/material.dart';

void canvasCenterRotation(Canvas canvas, double halfWidth, double halfHeight, double angle) {
  final double radians = angle / 180 * pi;
  canvas.translate(halfWidth, halfHeight);
  canvas.rotate(radians);
  canvas.translate(-halfWidth, -halfHeight);
}

void showToast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    duration: const Duration(seconds: 2),
  ));
}