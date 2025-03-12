import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/text_enum.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final TextType? type;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;

  final String content;
  const TextWidget(
      {super.key,
      this.type = TextType.normal,
      required this.content,
      this.size,
      this.weight,
      this.color,
      this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontSize: size ?? (type == TextType.normal ? kTextNormal : kTextTitle),
        fontWeight: weight ??
            (type == TextType.normal ? kTextWeightNormal : kTextWeightTitle),
        color: color ?? textColor,
      ),
      textAlign: align ?? TextAlign.start,
    );
  }
}
