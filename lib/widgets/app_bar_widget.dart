import 'package:ercomerce_app/widgets/back_button_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressBack;
  const AppBarWidget(
      {super.key, required this.title, required this.onPressBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButtonWidget(onPressed: onPressBack),
        TextWidget(
          content: title,
          size: 20,
          weight: FontWeight.w500,
        ),
        const SizedBox(
          width: 16,
        )
      ],
    );
  }
}
