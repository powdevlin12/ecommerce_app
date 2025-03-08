// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:ercomerce_app/models/cart_product.model.dart';
import 'package:ercomerce_app/utils/parse_type_value.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartModel {
  final String cartId;
  final String cart_state;
  final String cart_userId;
  final int cart_count_product;
  final List<CartProductModel> cart_product;

  const CartModel({
    required this.cartId,
    required this.cart_state,
    required this.cart_userId,
    required this.cart_count_product,
    required this.cart_product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: ParseTypeData.ensureString(json["_id"]),
      cart_state: ParseTypeData.ensureString(json["cart_state"]),
      cart_userId: ParseTypeData.ensureString(json["cart_userId"]),
      cart_count_product: ParseTypeData.ensureInt(json["cart_count_product"]),
      cart_product: (json['cart_product'] as List)
          .map((item) => CartProductModel.fromJson(item))
          .toList(),
    );
  }

  factory CartModel.empty() {
    return const CartModel(
        cartId: "",
        cart_state: "",
        cart_userId: "",
        cart_count_product: 0,
        cart_product: []);
  }
}
