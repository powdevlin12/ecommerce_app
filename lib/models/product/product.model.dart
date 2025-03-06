// ignore_for_file: non_constant_identifier_names

import 'package:ercomerce_app/models/product/product_attributes.model.dart';
import 'package:ercomerce_app/models/product/product_shop.model.dart';
import 'package:ercomerce_app/models/product/product_variations.model.dart';
import 'package:ercomerce_app/utils/parse_type_value.dart';

class ProductModel {
  final String productId;
  final String product_name;
  final String product_thumb;
  final String product_description;
  final int product_price;
  final int product_quantity;
  final String product_type;
  final ProductShopModel product_shop;
  final ProductAttributesModel product_attributes;
  final List<String> product_variations;
  final double product_rating_avg;
  final bool is_public;
  final bool is_draft;
  final String createdAt;
  final String updatedAt;

  const ProductModel({
    required this.productId,
    required this.createdAt,
    required this.is_draft,
    required this.is_public,
    required this.product_attributes,
    required this.product_description,
    required this.product_name,
    required this.product_price,
    required this.product_quantity,
    required this.product_rating_avg,
    required this.product_shop,
    required this.product_thumb,
    required this.product_type,
    required this.product_variations,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productId: ParseTypeData.ensureString(json["_id"]),
        createdAt: ParseTypeData.ensureString(json["createdAt"]),
        is_draft: ParseTypeData.ensureBool(json["is_draft"]),
        is_public: ParseTypeData.ensureBool(json["is_public"]),
        // product_attributes:
        // ProductAttributesModel.fromJson(json['product_attributes']),
        product_attributes: ProductAttributesModel.empty(),
        product_description:
            ParseTypeData.ensureString(json['product_description']),
        product_name: ParseTypeData.ensureString(json['product_name']),
        product_price: ParseTypeData.ensureInt(json['product_price']),
        product_quantity: ParseTypeData.ensureInt(json['product_quantity']),
        product_rating_avg:
            ParseTypeData.ensureDouble(json['product_rating_avg']),
        product_shop: ProductShopModel.empty(),
        product_thumb: ParseTypeData.ensureString(json['product_thumb']),
        product_type: ParseTypeData.ensureString(json['product_type']),
        product_variations:
            ParseTypeData.ensureListString(json['product_variations']),
        // product_variations: ProductVariationsModel.empty(),
        updatedAt: ParseTypeData.ensureString(json['updatedAt']));
  }
}
