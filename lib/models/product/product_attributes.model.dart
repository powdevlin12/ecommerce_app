import 'package:ercomerce_app/utils/parse_type_value.dart';

class ProductAttributesModel {
  final String manuifacturer;
  final String color;
  final String model_type;

  const ProductAttributesModel({
    required this.manuifacturer,
    required this.model_type,
    required this.color,
  });

  factory ProductAttributesModel.fromJson(Map<String, dynamic> json) {
    return ProductAttributesModel(
      manuifacturer: ParseTypeData.ensureString(json['manuifacturer']),
      model_type: ParseTypeData.ensureString(json['model_type']),
      color: ParseTypeData.ensureString(json['color']),
    );
  }

  factory ProductAttributesModel.empty() {
    return const ProductAttributesModel(
        manuifacturer: "", model_type: "", color: "");
  }

  Map<String, String> toJson() {
    return {"manuifacturer": "", "model_type": "", "color": ""};
  }
}
