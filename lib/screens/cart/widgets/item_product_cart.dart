import 'package:cached_network_image/cached_network_image.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/models/cart_product.model.dart';
import 'package:ercomerce_app/utils/format.dart';
import 'package:ercomerce_app/widgets/button_minus_widget.dart';
import 'package:ercomerce_app/widgets/button_plus_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ItemProductCart extends StatelessWidget {
  final CartProductModel cartProduct;
  const ItemProductCart({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: subBgColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: subBgColor,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: cartProduct.image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const Gap(12.0),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  content: cartProduct.name,
                  size: 15,
                  weight: FontWeight.w500,
                ),
                const Gap(12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      content: formatCurrency(cartProduct.price * 1.0),
                      color: primaryColor,
                      size: 14.0,
                      weight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        ButtonMinusWidget(
                          onTap: () => {},
                          sizeIcon: 20.0,
                          sizeSquare: 32.0,
                        ),
                        const Gap(6),
                        TextWidget(
                          content: cartProduct.quantity.toString(),
                          weight: FontWeight.bold,
                          size: 14.0,
                        ),
                        const Gap(6),
                        ButtonPlusWidget(
                          onTap: () => {},
                          sizeIcon: 20.0,
                          sizeSquare: 32.0,
                        ),
                      ],
                    )
                  ],
                ),
                const Gap(4.0),
              ],
            ),
          ),
          // Delete Button
        ],
      ),
    );
  }
}
