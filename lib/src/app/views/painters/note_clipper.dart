import 'package:flutter/material.dart';

class NoteFold extends CustomPainter {
  final Color color;
  const NoteFold({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = color;

    final path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NoteClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    const factor = 0.15;

    final path = Path()
      ..lineTo(w, 0)
      ..lineTo(w, h - h * factor)
      // ..quadraticBezierTo(w - w * factor, w * factor, w, w * factor)
      ..lineTo(w - w * factor, h)
      ..lineTo(0, h)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
