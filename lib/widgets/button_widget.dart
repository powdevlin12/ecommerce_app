import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/utils/convert_color.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final bool? isLoading;
  final Widget? leftWidget;

  const ButtonWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.textColor = Colors.white,
      this.borderRadius = 32.0,
      this.height = 50.0,
      this.width = double.infinity,
      this.textStyle,
      this.isLoading = false,
      this.leftWidget});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: (backgroundColor ?? primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
        child: !isLoading!
            ? (leftWidget != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      leftWidget!,
                      Text(
                        text,
                        style: textStyle ??
                            TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                      )
                    ],
                  )
                : Text(
                    text,
                    style: textStyle ??
                        TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ))
            : CircularProgressIndicator(
                color: subBgColor,
              ),
      ),
    );
  }
}
