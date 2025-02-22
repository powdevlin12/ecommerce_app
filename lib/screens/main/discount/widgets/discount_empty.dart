import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiscountEmpty extends StatelessWidget {
  final String? content;
  const DiscountEmpty({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.ads_click_sharp,
            size: 78,
          ),
          const Gap(16),
          TextWidget(
              content:
                  content ?? "Please type discount to search product apply!")
        ],
      ),
    );
  }
}
