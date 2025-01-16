import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh sản phẩm
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                product.product_thumb,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          // Tên sản phẩm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextWidget(
              content: product.product_name,
              color: textColor,
              weight: FontWeight.bold,
            ),
          ),
          // Giá sản phẩm
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextWidget(
              content: '${product.product_price} đ',
              color: dangerColorToast,
              size: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
