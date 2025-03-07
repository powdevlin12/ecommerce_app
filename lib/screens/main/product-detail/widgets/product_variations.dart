import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProductVariations extends StatelessWidget {
  final String variationActive;
  final GestureTapCallback onPressSelect;
  const ProductVariations(
      {super.key, required this.variationActive, required this.onPressSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
          color: subBgColor, borderRadius: BorderRadius.circular(24.0)),
      padding: const EdgeInsets.symmetric(
          horizontal: kPaddingHorizontal, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextWidget(
              content: "Storage", size: 15.0, weight: FontWeight.bold),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                content: variationActive,
                weight: FontWeight.bold,
              ),
              const Gap(16),
              InkWell(
                onTap: onPressSelect,
                child: SvgPicture.asset(
                  "assets/arrowdown.svg",
                  width: 28.0,
                  height: 28.0,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
