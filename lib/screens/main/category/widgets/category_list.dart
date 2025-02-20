import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/category.model.dart';
import 'package:ercomerce_app/screens/main/category/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryModel> listCategory;
  final StatusState status;

  const CategoryList(
      {super.key, required this.status, required this.listCategory});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: listCategory.length,
      separatorBuilder: (context, index) => const Gap(16),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryItem(category: listCategory[index]);
      },
      shrinkWrap: true,
    );
  }
}
