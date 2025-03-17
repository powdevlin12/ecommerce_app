import 'package:ercomerce_app/utils/responsive.dart';
import 'package:ercomerce_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const SearchWidget({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      controller: controller,
      prefixIcon: Icons.search,
      hintText: "Search ...",
      radius: Responsive.scale(16),
      onChanged: onChanged,
    );
  }
}
