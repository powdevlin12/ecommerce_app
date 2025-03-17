import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/screens/main/home/widgets/product_item.dart';
import 'package:ercomerce_app/utils/responsive.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<ProductModel> listProduct;
  final StatusState status;
  final String? title;
  final Color? color;
  const ProductList(
      {super.key,
      required this.listProduct,
      required this.status,
      this.title,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                content: title ?? 'Top Selling',
                weight: FontWeight.bold,
                color: color ?? primaryColor,
              ),
              TextWidget(
                content: 'SeeAll',
                size: Responsive.scale(12),
                weight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          (status != StatusState.loadCompleted)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: CircularProgressIndicator(color: primaryColor)),
                )
              : SizedBox(
                  height: Responsive.scale(240),
                  width: double
                      .infinity, // Đảm bảo ListView có chiều rộng full màn hình
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    scrollDirection: Axis.horizontal,
                    physics:
                        const BouncingScrollPhysics(), // Hiệu ứng cuộn mượt
                    itemCount: listProduct.length,
                    itemBuilder: (context, index) {
                      return ProductItem(product: listProduct[index]);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
