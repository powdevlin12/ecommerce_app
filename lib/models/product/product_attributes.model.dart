import 'package:ercomerce_app/utils/parse_type_value.dart';

class ProductAttributesModel {
  final String manuifacturer;
  final String violet;
  final String model_type;

  const ProductAttributesModel({
    required this.manuifacturer,
    required this.model_type,
    required this.violet,
  });

  factory ProductAttributesModel.fromJson(Map<String, dynamic> json) {
    return ProductAttributesModel(
      manuifacturer: ParseTypeData.ensureString(json['manuifacturer']),
      model_type: ParseTypeData.ensureString(json['name']),
      violet: ParseTypeData.ensureString(json['name']),
    );
  }

  factory ProductAttributesModel.empty() {
    return const ProductAttributesModel(
        manuifacturer: "", model_type: "", violet: "");
  }

  Map<String, String> toJson() {
    return {"manuifacturer": "", "model_type": "", "violet": ""};
  }
}
