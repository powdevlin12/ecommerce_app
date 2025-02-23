import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/models/product/discount.model.dart';
import 'package:ercomerce_app/utils/format.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ItemMyDiscount extends StatelessWidget {
  final DiscountModel discount;
  const ItemMyDiscount({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kPaddingHorizontal, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: subBgColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                content: discount.discountName,
                weight: FontWeight.w500,
              ),
              Icon(
                Icons.adjust_rounded,
                color:
                    discount.discountIsActive ? greenColor : dangerColorToast,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                content: discount.discountCode,
                weight: FontWeight.bold,
              ),
              TextWidget(
                content: "Max user use ${discount.discountMaxUses}",
                size: 14.0,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                content: "User used : ${discount.discountUsersUsed.length}",
                size: 14,
              ),
              TextWidget(
                content:
                    "Amount of product apply : ${discount.discountProductIds.length}",
                size: 14,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                content: "Start: ${formatDate(discount.discountStartDate)}",
                size: 14.0,
              ),
              TextWidget(
                content: "End: ${formatDate(discount.discountEndDate)}",
                size: 14.0,
              )
            ],
          )
        ],
      ),
    );
  }
}
