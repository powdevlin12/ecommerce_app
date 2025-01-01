import 'package:ercomerce_app/utils/parse_type_value.dart';

class ShopModel {
  final String id;
  final String name;
  final String email;

  ShopModel({required this.id, required this.name, required this.email});

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: ParseTypeData.ensureString(json["_id"]),
      name: ParseTypeData.ensureString(json["name"]),
      email: ParseTypeData.ensureString(json["email"]),
    );
  }
}
