import 'package:ercomerce_app/utils/parse_type_value.dart';

class TokenModel {
  final String accessToken;
  final String refreshToken;

  TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: ParseTypeData.ensureString(json["accessToken"]),
      refreshToken: ParseTypeData.ensureString(json["refreshToken"]),
    );
  }
}
