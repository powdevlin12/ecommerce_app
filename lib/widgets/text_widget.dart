import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/text_enum.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final TextType? type;
  final String content;
  const TextWidget({super.key, this.type, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontSize: type == TextType.normal ? kTextNormal : kTextTitle,
        fontWeight:
            type == TextType.normal ? kTextWeightNormal : kTextWeightTitle,
      ),
    );
  }
}
