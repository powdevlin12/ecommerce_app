import 'package:flutter/material.dart';
import 'package:ercomerce_app/configs/colors.dart';

class SquareIcon extends StatelessWidget {
  final Widget iconsSvg;
  static const sizeSquare = 40.0;
  const SquareIcon({super.key, required this.iconsSvg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: sizeSquare, // Kích thước hình tròn
        height: sizeSquare,
        decoration: BoxDecoration(
          color: primaryColor, // Nền màu đen
          shape: BoxShape.circle, // Hình dạng tròn
        ),
        child: Center(
          child: iconsSvg,
        ),
      ),
    );
  }
}
