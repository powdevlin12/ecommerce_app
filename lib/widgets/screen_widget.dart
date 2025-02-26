import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:flutter/material.dart';

class ScreenWidget extends StatelessWidget {
  final Widget child;
  final double? paddingTop;
  final AppBar? appBar;

  const ScreenWidget(
      {super.key, required this.child, this.paddingTop, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: kPaddingHorizontal, vertical: paddingTop ?? 0),
            child: child,
          ),
        ));
  }
}
