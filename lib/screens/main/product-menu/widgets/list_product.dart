import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/screens/main/product-menu/widgets/item_product.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatelessWidget {
  final List<ProductModel> listProduct;
  final StatusState status;
  final Function() onRefresh;
  final Function() onLoadMore;
  final bool isLoadingMore;

  const ListProduct({
    super.key,
    required this.listProduct,
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
                      itemCount: listProduct.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        debugPrint('index: $index');
                        if (index == listProduct.length) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: Column(
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                      color: primaryColor),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Loading more...',
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
                        ProductModel product = listProduct[index];
                        return ItemProduct(
                          product: product,
                          onRefresh: onRefresh,
                        );
                      },
                    ),
                  ),
                ),
                if (listProduct.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Showing ${listProduct.length} products${isLoadingMore ? ", loading more..." : ""}',
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
