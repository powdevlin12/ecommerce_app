import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileOption extends StatelessWidget {
  final String title;
  final GestureTapCallback onPress;
  static const sizeIcon = 24.0;
  const ProfileOption({super.key, required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: subBgColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kPaddingHorizontal, vertical: kPaddingHorizontal * 1.2),
        child: InkWell(
          onTap: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                content: title,
                weight: FontWeight.w500,
              ),
              SvgPicture.asset(
                "assets/arrowright.svg",
                width: sizeIcon,
                height: sizeIcon,
              )
            ],
          ),
        ),
      ),
    );
  }
}
