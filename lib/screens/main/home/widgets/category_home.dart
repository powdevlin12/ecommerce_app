import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CategoryHome extends StatelessWidget {
  const CategoryHome({super.key});

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
            height: sizeItem, // Chiều cao cho ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Cuộn ngang
              itemCount: 10, // Số lượng item
              itemBuilder: (context, index) {
                return Container(
                  width: sizeItem,
                  height: sizeItem, // Chiều rộng của mỗi item
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(sizeItem / 2),
                  ),
                  child: Center(
                    child: Text(
                      "Item $index",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
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
