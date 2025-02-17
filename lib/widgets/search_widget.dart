import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: inputBg,
          borderRadius: const BorderRadius.all(Radius.circular(kCornerMedium))),
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/search.svg",
            width: 30.0,
            height: 30.0,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(
            width: kPaddingHorizontal / 2,
          ),
          const TextWidget(content: "Search")
        ],
      ),
    );
  }
}
