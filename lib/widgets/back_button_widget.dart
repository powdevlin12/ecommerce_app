import 'package:ercomerce_app/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:ercomerce_app/utils/convert_color.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const BackButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        color: hexToColor(subBgColor),
      ),
      alignment: Alignment.center,
      // color: hexToColor(subBgColor),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onPressed,
      ),
    );
  }
}
