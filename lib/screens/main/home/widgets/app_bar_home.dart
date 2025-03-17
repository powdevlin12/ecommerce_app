import 'package:ercomerce_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarHome extends StatelessWidget {
  final GestureTapCallback onPressCart;
  const AppBarHome({super.key, required this.onPressCart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.scale(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            height: Responsive.scale(48),
            width: Responsive.scale(48),
            decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(
                    side: BorderSide(width: 2, color: Colors.blue))),
            child: SvgPicture.asset("assets/avatar.svg",
                width: Responsive.scale(30),
                height: Responsive.scale(30),
                fit: BoxFit.scaleDown),
          ),
          SizedBox(
            height: Responsive.scale(48),
            child: InkWell(
              onTap: onPressCart,
              child: SvgPicture.asset(
                "assets/cart.svg",
                width: Responsive.scale(48),
                height: Responsive.scale(48),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
