import 'dart:ffi';

import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/discount.model.dart';
import 'package:ercomerce_app/screens/main/my-discount/widgets/item_my_discount.dart';
import 'package:flutter/material.dart';

class ListMyDiscount extends StatelessWidget {
  final List<DiscountModel> listDiscount;
  final StatusState status;
  final Function() onRefresh;
  final Function() onLoadMore;
  final bool isLoadingMore;

  const ListMyDiscount({
    super.key,
    required this.listDiscount,
    required this.status,
    required this.onRefresh,
    required this.onLoadMore,
    required this.isLoadingMore,
  });

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
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent &&
                          !isLoadingMore) {
                        onLoadMore();
                        return true;
                      }
                      return false;
                    },
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: listDiscount.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == listDiscount.length) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                      color: primaryColor),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Đang tải thêm...',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        DiscountModel discount = listDiscount[index];
                        if (!discount.isDelete)
                          return ItemMyDiscount(
                            discount: discount,
                            onRefresh: onRefresh,
                          );
                        return null;
                      },
                    ),
                  ),
                ),
                // Hiển thị thông báo tổng số item
                if (listDiscount.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Hiển thị ${listDiscount.length} discount${isLoadingMore ? ", đang tải thêm..." : ""}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
