import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/text_enum.dart';
import 'package:ercomerce_app/utils/responsive.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final TextType? type;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  final String content;
  const TextWidget(
      {super.key,
      this.type = TextType.normal,
      required this.content,
      this.size,
      this.weight,
      this.color,
      this.align,
      this.maxLines,
      this.overflow});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Text(
      content,
      style: TextStyle(
          fontSize: size ??
              (type == TextType.normal
                  ? Responsive.scale(16)
                  : Responsive.scale(32)),
          fontWeight: weight ??
              (type == TextType.normal ? kTextWeightNormal : kTextWeightTitle),
          color: color ?? textColor,
          fontFamily: 'Regular'),
      textAlign: align ?? TextAlign.start,
      maxLines: maxLines ?? DefaultTextStyle.of(context).maxLines,
      overflow: overflow ?? DefaultTextStyle.of(context).overflow,
    );
  }
}
