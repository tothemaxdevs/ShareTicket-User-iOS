import 'package:flutter/material.dart';

class DolDurmaClipper extends CustomClipper<Path> {
  DolDurmaClipper({required this.right, required this.holeRadius});

  final double right;
  final double holeRadius;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
//For left side shape of container
      ..lineTo(0.0, size.height - 100 - holeRadius)
      ..arcToPoint(
        Offset(0, size.height - 100),
        clockwise: true,
        radius: Radius.circular(1),
      )
      ..lineTo(0.0, size.height - 50 - holeRadius)
      ..arcToPoint(
        Offset(0, size.height - 50),
        clockwise: true,
        radius: Radius.circular(1),
      )
//For Right side shape of container
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height - 100)
      ..arcToPoint(
        Offset(size.width, size.height - 100 - holeRadius),
        clockwise: true,
        radius: Radius.circular(1),
      )
      ..lineTo(size.width, size.height - 50)
      ..arcToPoint(
        Offset(size.width, size.height - 50 - holeRadius),
        clockwise: true,
        radius: Radius.circular(1),
      );

    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}
