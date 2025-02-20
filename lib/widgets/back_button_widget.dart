import 'package:ercomerce_app/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const BackButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: subBgColor,
        ),
        alignment: Alignment.center,
        // color: hexToColor(subBgColor),
        child: SvgPicture.asset(
          "assets/arrowleft.svg",
          width: 20.0,
          height: 20.0,
        ),
      ),
    );
  }
}
