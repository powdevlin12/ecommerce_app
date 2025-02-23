import 'dart:ffi';

import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/discount.model.dart';
import 'package:ercomerce_app/screens/main/my-discount/widgets/item_my_discount.dart';
import 'package:flutter/material.dart';

class ListMyDiscount extends StatelessWidget {
  final List<DiscountModel> listDiscount;
  final StatusState status;

  const ListMyDiscount(
      {super.key, required this.listDiscount, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: status != StatusState.loadCompleted
            ? Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      scrollDirection: Axis.vertical,
                      physics:
                          const BouncingScrollPhysics(), // Hiệu ứng cuộn mượt
                      itemCount: listDiscount.length,
                      itemBuilder: (context, index) {
                        return ItemMyDiscount(discount: listDiscount[index]);
                      },
                    ),
                  ),
                ],
              ));
  }
}
