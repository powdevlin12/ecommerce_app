// ignore_for_file: non_constant_identifier_names

import 'package:ercomerce_app/utils/parse_type_value.dart';

class CartProductModel {
  final String cartProductId;
  final String productId;
  final String shopId;
  final int quantity;
  final String name;
  final String image;
  final int price;

  const CartProductModel(
      {required this.cartProductId,
      required this.productId,
      required this.shopId,
      required this.quantity,
      required this.name,
      required this.price,
      required this.image});

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      cartProductId: ParseTypeData.ensureString(json["_id"]),
      productId: ParseTypeData.ensureString(json["productId"]),
      shopId: ParseTypeData.ensureString(json["shopId"]),
      quantity: ParseTypeData.ensureInt(json["quantity"]),
      name: ParseTypeData.ensureString(json["name"]),
      price: ParseTypeData.ensureInt(json["price"]),
      image: ParseTypeData.ensureString(json["image"]),
    );
  }

  factory CartProductModel.empty() {
    return const CartProductModel(
        cartProductId: "",
        name: "",
        price: 0,
        productId: "",
        quantity: 0,
        shopId: "",
        image: "");
  }
}
