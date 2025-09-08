import 'dart:io';

import 'package:flutter/material.dart';

class DashedCircle extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;
  final String assetImage;
  final String? file;

  const DashedCircle({
    super.key,
    this.size = 100,
    this.color = Colors.grey,
    this.strokeWidth = 1.5,
    this.dashLength = 6,
    this.dashGap = 4,
    this.file ,
    required this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Dashed circular border
        CustomPaint(
          size: Size(size, size),
          painter: _DashedCirclePainter(
            color: color,
            strokeWidth: strokeWidth,
            dashLength: dashLength,
            dashGap: dashGap,
          ),
        ),
        // Rounded image from assets inside
        if (file!=null&&file!.isNotEmpty) ClipOval(
          child: file!.contains('http')?Image.network(file??'', width: 67, height: 67, fit: BoxFit.cover):Image.file(File(file??''), width: 67, height: 67, fit: BoxFit.cover),
        ) else ClipOval(
          child: Image.asset(assetImage, width: 67, height: 67, fit: BoxFit.cover),
        ),
      ],
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;

  _DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final double radius = size.width / 2;
    final double circumference = 2 * 3.14159265359 * radius;
    final double dashCount = circumference / (dashLength + dashGap);
    final double radiansPerDash = (2 * 3.14159265359) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = i * radiansPerDash;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        dashLength / radius,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
