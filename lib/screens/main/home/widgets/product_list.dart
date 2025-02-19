import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/screens/main/home/widgets/product_item.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
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
              const TextWidget(
                content: 'SeeAll',
                size: 14,
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
              : Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Số cột
                      crossAxisSpacing: 10.0, // Khoảng cách giữa các cột
                      mainAxisSpacing: 10.0, // Khoảng cách giữa các hàng
                      childAspectRatio:
                          0.7, // Tỉ lệ chiều rộng / chiều cao của ô
                    ),
                    itemCount: listProduct.length,
                    itemBuilder: (context, index) {
                      return ProductItem(product: listProduct[index]);
                    },
                  ),
                )
        ],
      ),
    );
  }
}
