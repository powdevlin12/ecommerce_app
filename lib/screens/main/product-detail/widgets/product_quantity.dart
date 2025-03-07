import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/widgets/square_icon.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProductQuantity extends StatelessWidget {
  final int quantity;
  final GestureTapCallback onPlus;
  final GestureTapCallback onMinus;
  const ProductQuantity(
      {super.key,
      required this.quantity,
      required this.onMinus,
      required this.onPlus});

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
              content: "Quantity", size: 15.0, weight: FontWeight.bold),
          Row(
            children: [
              InkWell(
                onTap: onMinus,
                child: SquareIcon(
                  iconsSvg: SvgPicture.asset(
                    "assets/minus.svg",
                    width: 20.0,
                    height: 20.0,
                  ),
                ),
              ),
              const Gap(12.0),
              TextWidget(
                content: quantity.toString(),
                weight: FontWeight.bold,
                size: 17.0,
              ),
              const Gap(12.0),
              InkWell(
                onTap: onPlus,
                child: SquareIcon(
                  iconsSvg: SvgPicture.asset(
                    "assets/add.svg",
                    width: 20.0,
                    height: 20.0,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
