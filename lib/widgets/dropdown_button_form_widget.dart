import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/utils/convert_color.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DropdownButtonFormWidget extends StatelessWidget {
  final String selectedValue;
  final String labelText;
  final List<String> listOptions;
  final Function onChanged;
  const DropdownButtonFormWidget(
      {super.key,
      required this.selectedValue,
      required this.labelText,
      required this.listOptions,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: (primaryColor)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: hexToColor(inputBackgroundColor)),
        ),
        fillColor: hexToColor(inputBackgroundColor),
        filled: true,
      ),
      items: listOptions.map((String type) {
        return DropdownMenuItem(
          value: type,
          child: TextWidget(
            content: type,
            size: 14.0,
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        onChanged(newValue);
      },
    );
  }
}
