import 'package:cached_network_image/cached_network_image.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/category.model.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CategoryHome extends StatelessWidget {
  final List<CategoryModel> listCategory;
  final StatusState status;

  const CategoryHome(
      {super.key, required this.listCategory, required this.status});

  static const double sizeItem = 60.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                content: "Categories",
                weight: FontWeight.bold,
              ),
              TextWidget(
                content: "SeeAll",
                size: 14,
                weight: FontWeight.w500,
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: sizeItem * 1.3, // Chiều cao cho ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Cuộn ngang
              itemCount: listCategory.length, // Số lượng item
              itemBuilder: (context, index) {
                CategoryModel category = listCategory[index];
                return Container(
                  width: sizeItem * 1.2,
                  height: sizeItem, // Chiều rộng của mỗi item
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: sizeItem,
                        width: sizeItem,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              sizeItem), // Đặt độ cong bo góc
                          child: CachedNetworkImage(
                            imageUrl: category.image,
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
                      Center(
                        child: TextWidget(
                          content: category.name,
                          size: 12,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
