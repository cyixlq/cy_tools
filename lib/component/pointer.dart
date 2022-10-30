
import 'dart:math';

import 'package:flutter/material.dart';

class Pointer extends StatelessWidget {

  final double width;
  final double height;

  const Pointer({
    super.key,
    this.width = 0,
    this.height = 0
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cons) {
      return CustomPaint(
        size: _getSize(cons.maxWidth, cons.maxHeight),
        painter: _PointerPainter(),
      );
    });
  }

  Size _getSize(
      double parentWidth,
      double parentHeight
      ) {
    final w = max(width, parentWidth);
    final h = max(height, parentHeight);
    return Size(w, h);
  }

}

class _PointerPainter extends CustomPainter {

  static const _halfPointW = 20;
  final Paint _paint = Paint()..color = Colors.white;
  final Path _path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width / 2, size.height / 2) / 8;
    final long = min(size.width / 2, size.height / 2) / 2;
    final halfW = size.width / 2;
    final halfH = size.height / 2;
    canvas.drawCircle(Offset(halfW, halfH), radius, _paint);
    _path.reset();
    _path..moveTo(halfW - _halfPointW, halfH)
      ..lineTo(halfW, halfH - long)
      ..lineTo(halfW + _halfPointW, halfH)
      ..close();
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}