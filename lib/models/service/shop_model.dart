import 'package:ercomerce_app/utils/parse_type_value.dart';

class ShopModel {
  final String shopId;
  final String name;
  final String email;
  final String password;
  final String status;
  final List<String> roles;
  final bool verify;
  final String createAt;
  final String updatedAt;

  const ShopModel(
      {required this.shopId,
      required this.createAt,
      required this.email,
      required this.name,
      required this.password,
      required this.status,
      required this.updatedAt,
      required this.verify,
      required this.roles});

  factory ShopModel.empty() {
    return const ShopModel(
        shopId: "",
        createAt: "",
        email: "",
        name: "",
        password: "",
        status: "",
        updatedAt: "",
        verify: false,
        roles: []);
  }

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      shopId: ParseTypeData.ensureString(json['shopId']),
      name: ParseTypeData.ensureString(json['name']),
      email: ParseTypeData.ensureString(json['email']),
      password: ParseTypeData.ensureString(json['password']),
      status: ParseTypeData.ensureString(json['status']),
      verify: ParseTypeData.ensureBool(json['verify']),
      roles: ParseTypeData.ensureListString(json['roles']),
      createAt: ParseTypeData.ensureString(json['createAt']),
      updatedAt: ParseTypeData.ensureString(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "shopId": shopId,
      "name": name,
      "email": email,
      "password": password,
      "status": status,
      "verify": verify,
      "roles": roles,
      "createAt": createAt,
      "updatedAt": updatedAt,
    };
  }

  String get getName {
    return name;
  }
}
