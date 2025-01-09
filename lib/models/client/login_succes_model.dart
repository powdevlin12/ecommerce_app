import 'package:ercomerce_app/models/service/shop_model.dart';
import 'package:ercomerce_app/models/client/token_model.dart';

class LoginSuccess {
  final ShopModel shop;
  final TokenModel tokens;

  LoginSuccess({required this.shop, required this.tokens});

  factory LoginSuccess.fromJson(Map<String, dynamic> json) {
    return LoginSuccess(
        shop: ShopModel.fromJson(json['shop']),
        tokens: TokenModel.fromJson(json['tokens']));
  }
}
