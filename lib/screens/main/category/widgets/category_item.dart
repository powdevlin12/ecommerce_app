import 'package:cached_network_image/cached_network_image.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/models/product/category.model.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: subBgColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                height: 60,
                width: 60,
                imageUrl: category.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const Gap(16),
            TextWidget(
              content: category.name,
              weight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
