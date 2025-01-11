import 'package:ercomerce_app/utils/parse_type_value.dart';

class ProductShopModel {
  final String name;
  final String email;

  const ProductShopModel({
    required this.email,
    required this.name,
  });

  factory ProductShopModel.fromJson(Map<String, dynamic> json) {
    return ProductShopModel(
        email: ParseTypeData.ensureString(json['email']),
        name: ParseTypeData.ensureString(json['name']));
  }

  factory ProductShopModel.empty(Map<String, dynamic> json) {
    return const ProductShopModel(
      email: "",
      name: "",
    );
  }

  Map<String, String> toJson() {
    return {
      "email": "",
      "name": "",
    };
  }
}
