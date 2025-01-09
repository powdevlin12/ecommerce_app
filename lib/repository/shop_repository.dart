import 'package:ercomerce_app/models/service/shop_model.dart';

class ShopRepository {
  static ShopModel? _shopModel;

  static void setUserModel(Map<String, dynamic>? json) {
    _shopModel = json == null ? null : ShopModel.fromJson(json);
  }

  static ShopModel? get userModel {
    if (_shopModel == null) {
      return ShopModel.empty();
    }
    return _shopModel;
  }

  ///Singleton factory
  static final ShopRepository _instance = ShopRepository._internal();

  factory ShopRepository() {
    return _instance;
  }

  ShopRepository._internal();
}
