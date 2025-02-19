import 'package:ercomerce_app/utils/parse_type_value.dart';

class CategoryModel {
  final String categoryId;
  final String name;
  final String image;

  const CategoryModel(
      {required this.categoryId, required this.image, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: ParseTypeData.ensureString(json["_id"]),
      image: ParseTypeData.ensureString(json["image"]),
      name: ParseTypeData.ensureString(json["name"]),
    );
  }
}
