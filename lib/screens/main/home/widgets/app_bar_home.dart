import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarHome extends StatelessWidget {
  final GestureTapCallback onPressCart;
  const AppBarHome({super.key, required this.onPressCart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            height: 48,
            width: 48,
            decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(
                    side: BorderSide(width: 2, color: Colors.blue))),
            child: SvgPicture.asset("assets/avatar.svg",
                width: 30.0, height: 30.0, fit: BoxFit.scaleDown),
          ),
          SizedBox(
            height: 48,
            child: InkWell(
              onTap: onPressCart,
              child: SvgPicture.asset(
                "assets/cart.svg",
                width: 48.0,
                height: 48.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
