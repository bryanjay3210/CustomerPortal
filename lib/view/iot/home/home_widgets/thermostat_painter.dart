import 'package:flutter/material.dart';
import 'dart:math';

class ThermostatValuePainter extends CustomPainter {
  //
  Color defaultCircleColor;
  Color percentageCompletedCircleColor;
  double completedPercentage;
  double circleWidth;

  ThermostatValuePainter(
      {required this.defaultCircleColor,
      required this.percentageCompletedCircleColor,
      required this.completedPercentage,
      required this.circleWidth});

  getPaint(Color color) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultCirclePaint = getPaint(defaultCircleColor);

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    Rect boundingSquare = Rect.fromCircle(center: center, radius: radius);

    paint(
      List<Color> colors,
    ) {
      final Gradient gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        colors: colors,
      );

      return Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = circleWidth
        ..shader = gradient.createShader(boundingSquare);
    }

    canvas.drawCircle(center, radius, defaultCirclePaint);

    double arcAngle = 2 * pi * (completedPercentage / 100);
    final res = int.parse(completedPercentage.toString().split('.')[0]) - 65;
    final temp = res >= 1 ? res : 1;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / .3,
      arcAngle,
      false,
      paint(
        [
          if (completedPercentage <= 76.99)
            Color.fromRGBO(50, (150 + (temp * 8)), 255, 1),
          if (completedPercentage <= 76.99)
            Color.fromRGBO(50, (50 + (temp * 8)), 255, 1),
          if (completedPercentage >= 77)
            Color.fromRGBO(255, (289 - (temp * 5)), 29, 1),
          if (completedPercentage >= 77)
            Color.fromRGBO(255, (196 - (temp * 5)), 29, 1),
        ],
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }
}
