import 'package:ercomerce_app/utils/parse_type_value.dart';

class ProductVariationsModel {
  final List<String> variations;

  const ProductVariationsModel({required this.variations});

  factory ProductVariationsModel.fromJson(Map<String, dynamic> json) {
    return ProductVariationsModel(
      variations: ParseTypeData.ensureListString(json['variations']),
    );
  }

  factory ProductVariationsModel.empty() {
    return const ProductVariationsModel(variations: []);
  }

  Map<String, String> toJson() {
    return {
      "variations": "",
    };
  }
}
