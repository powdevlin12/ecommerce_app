import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/widgets/square_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonPlusWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final double? sizeSquare;
  final double? sizeIcon;

  const ButtonPlusWidget(
      {super.key,
      required this.onTap,
      this.sizeSquare = 40,
      this.sizeIcon = 20});

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
          child: InkWell(
            onTap: onTap,
            child: SquareIcon(
              iconsSvg: SvgPicture.asset(
                "assets/add.svg",
                width: sizeIcon,
                height: sizeIcon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
