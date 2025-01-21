import 'package:cached_network_image/cached_network_image.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/utils/format.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: backgroundColor,
      elevation: 5,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ảnh sản phẩm
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: CachedNetworkImage(
                    imageUrl: product.product_thumb,
                    // height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              // Tên sản phẩm
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: TextWidget(
                  content: product.product_name,
                  color: textColor,
                  size: 14.0,
                  // weight: FontWeight.w400,
                ),
              ),
              // Giá sản phẩm
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextWidget(
                  content: formatCurrency(product.product_price.toDouble()),
                  size: 14.0,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Positioned(
            right: 4.0,
            top: 12.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SvgPicture.asset(
                "assets/heart.svg",
                width: 20.0,
                height: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
