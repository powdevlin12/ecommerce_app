import 'package:flutter/material.dart';

Color hexToColor(String code) {
  return Color(int.parse(code.replaceFirst('#', '0xFF')));
}
