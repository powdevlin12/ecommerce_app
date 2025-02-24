import 'package:ercomerce_app/widgets/back_button_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressBack;
  final Widget? rightActionWidget;
  final double? paddingTop;
  const AppBarWidget(
      {super.key,
      required this.title,
      required this.onPressBack,
      this.rightActionWidget,
      this.paddingTop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop ?? 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButtonWidget(onPressed: onPressBack),
          TextWidget(
            content: title,
            size: 18,
            weight: FontWeight.w500,
          ),
          rightActionWidget ?? const SizedBox.shrink()
        ],
      ),
    );
  }
}
