import 'dart:ffi';

import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/utils/convert_color.dart';
import 'package:ercomerce_app/utils/responsive.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final double? radius;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final double? height;
  final String? label;
  final int? maxLines;

  const TextFieldWidget(
      {super.key,
      this.hintText,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.onChanged,
      this.textInputAction,
      this.radius,
      this.height,
      this.label,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: height ?? 48,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines ?? 1,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textInputAction: textInputAction,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: Responsive.scale(14)),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: kPaddingHorizontal),
          hintText: hintText ?? "",
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400, fontSize: Responsive.scale(14)),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 12.0),
            borderSide: BorderSide(color: (primaryColor)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 10.0),
            borderSide: BorderSide(color: hexToColor(inputBackgroundColor)),
          ),
          fillColor: hexToColor(inputBackgroundColor),
          filled: true,
        ),
      ),
    );
  }
}
