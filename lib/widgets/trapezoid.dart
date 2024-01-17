import 'package:flutter/cupertino.dart';

class ClipTrapezoid extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    Path path = Path();
    path.moveTo(width * 0.2, 0);
    path.lineTo(width * 0.8, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }


  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}