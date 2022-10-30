
import 'dart:math';

import 'package:cy_tools/common/utils.dart';
import 'package:flutter/material.dart';

class TurnTable extends StatelessWidget {

  final List<String> gifts;
  final double width;
  final double height;

  const TurnTable({
    super.key,
    required this.gifts,
    this.width = 0,
    this.height = 0
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cons) {
      return CustomPaint(
        size: _getSize(cons.maxWidth, cons.maxHeight),
        painter: _TurnTablePainter(this),
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

class _TurnTablePainter extends CustomPainter {

  final TurnTable widget;
  final int count;
  final double itemAngel;
  final Paint _paint = Paint();
  final textPaint = TextPainter(textDirection: TextDirection.ltr);

  _TurnTablePainter(this.widget)
      : count = widget.gifts.length,
        itemAngel = 360 / widget.gifts.length;

  @override
  void paint(Canvas canvas, Size size) {
    final halfW = size.width / 2;
    final halfH = size.height / 2;
    final radius = min(size.width / 2, size.height / 2) - 8;
    final smallRadius = radius / 4;
    _paint..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawCircle(
        Offset(halfW, halfH),
        radius,
        _paint
    );
    _paint..strokeWidth = 8
      ..style = PaintingStyle.fill
      ..color = Colors.red;
    canvas.drawCircle(Offset(halfW, halfH), radius - 4, _paint);
    _paint.color = Colors.yellow;
    canvas.drawCircle(Offset(halfW, halfH), smallRadius, _paint);
    _paint..color = Colors.yellow
      ..strokeWidth = 2;
    canvas.save();
    for (int i = 0; i < count; i++) {
      canvas.drawLine(
          Offset(halfW, halfH),
          Offset(halfW, halfH - radius),
          _paint
      );
      canvasCenterRotation(canvas, halfW, halfH, itemAngel);
    }
    canvas.restore();
    canvas.save();
    canvasCenterRotation(canvas, halfW, halfH, -(90 - (itemAngel / 2)));
    for (int j = 0; j < count; j++) {
      final textSpan = TextSpan(
        text: widget.gifts[j],
        style: const TextStyle(
          color: Colors.yellow,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        )
      );
      textPaint.text = textSpan;
      textPaint.layout(maxWidth: radius / 1.5);
      textPaint.paint(
        canvas,
        Offset(halfW + radius - textPaint.width - 12, halfH - textPaint.height / 2)
      );
      canvasCenterRotation(canvas, halfW, halfH, itemAngel);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}