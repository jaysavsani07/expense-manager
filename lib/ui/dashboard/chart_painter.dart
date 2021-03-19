import 'dart:math' as math;

import 'package:flutter/material.dart';

class PieChartPainter extends CustomPainter {
  List<Paint> _paintList = [];
  List<double> _subParts;
  double _total = 0;
  double _totalAngle = math.pi * 2;

  final double initialAngle;
  final double strokeWidth;
  final Color emptyColor;

  double _prevAngle = 0;

  PieChartPainter(
    double angleFactor,
    List<Color> colorList, {
    @required List<double> values,
    this.initialAngle,
    this.strokeWidth,
    this.emptyColor,
  }) {
    _total = values.fold(0, (v1, v2) => v1 + v2);
    for (int i = 0; i < values.length; i++) {
      final paint = Paint()..color = colorList[i];
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = strokeWidth;
      paint.strokeCap = StrokeCap.round;
      _paintList.add(paint);
    }
    _subParts = values;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.width < size.height ? size.width : size.height;
    if (_total == 0) {
      final paint = Paint()..color = emptyColor;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = strokeWidth;
      canvas.drawArc(
        new Rect.fromLTWH(0.0, 0.0, side, size.height),
        _prevAngle,
        360,
        false,
        paint,
      );
    } else if (_subParts.length == 1) {
      canvas.drawArc(
        new Rect.fromLTWH(0.0, 0.0, side, size.height),
        _prevAngle,
        360,
        false,
        _paintList[0],
      );
    } else {
      _prevAngle = this.initialAngle * math.pi / 180;
      for (int i = 0; i < _subParts.length; i++) {
        canvas.drawArc(
          new Rect.fromLTWH(0.0, 0.0, side, size.height),
          _prevAngle,
          (((_totalAngle) / _total) * _subParts[i] - 0.4),
          false,
          _paintList[i],
        );
        _prevAngle = _prevAngle + (((_totalAngle) / _total) * _subParts[i]);
      }
    }
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) =>
      oldDelegate._totalAngle != _totalAngle;
}
