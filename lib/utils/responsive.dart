import 'package:flutter/material.dart';

class Responsive {
  // Biến tĩnh để lưu kích thước màn hình và kích thước chuẩn
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static const double _designWidth = 428; // Chiều rộng chuẩn (iPhone X)
  static const double _designHeight = 926; // Chiều cao chuẩn (iPhone X)

  // Hàm khởi tạo để lấy kích thước màn hình
  static void init(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
  }

  // Hàm scale chiều rộng
  static double scale(int size) {
    double ratioDefault = _designHeight / _designWidth;
    double ratioCurrent = _screenHeight / _screenWidth;
    double scaleVer = _screenHeight / _designHeight;
    double scaleHoz = _screenWidth / _designWidth;

    double sizeRatio = ratioCurrent <= 1.6 ? size / 2.0 : size.toDouble();

    if (ratioCurrent > ratioDefault) {
      return (sizeRatio * scaleVer).round() * 1.0;
    }
    return (sizeRatio * scaleHoz).round() * 1.0;
  }
}
