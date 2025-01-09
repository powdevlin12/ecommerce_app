import 'package:ercomerce_app/api/http_manager.dart';
import 'package:ercomerce_app/blocs/domain/domain_cubit.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';

class Api {
  static final httpManager = HTTPManager();
  static const String https = "https://";
  static const String http = "http://";
  static String domain = "localhost";
  static String accessToken = "";
  static String shopId = "";

  static String getProtocol() {
    const bool useSsl = false;
    String protocol = (useSsl ? Api.https : Api.http);
    return protocol;
  }

  static String localHost() {
    // return "restaurantbe-production.up.railway.app";
    return domain;
  }

  static String branchGetter() {
    String branch = "${getProtocol()}${domain ?? localHost()}:3012";
    return branch;
  }

  static String appendBranch(String operation) {
    return "${branchGetter()}$operation";
  }

  static cancelRequest({String tag = ""}) {
    httpManager.cancelRequest(tag: tag);
  }

  static void cancelAllRequest() {
    httpManager.cancelAllRequest();
  }

  static String buildIncreaseTagRequestWithID(String identifier) {
    return "${identifier}_${DateTime.now()}";
  }

  static String versionApi = "/v1/api";
  static String loginUrl = "$versionApi/login";
  static String signUpUrl = "$versionApi/sign-up";
  static String getMeUrl = "$versionApi/me";

  static Future<ResultModel> requestSignUp({
    String email = "",
    String name = "",
    String password = "",
    String domain = "",
    String tagRequest = HTTPManager.DEFAULT_CANCEL_TAG,
  }) async {
    var params = {
      "email": email,
      "password": password,
      "name": name,
    };
    final result = await httpManager.post(
      url: appendBranch(signUpUrl),
      data: params,
      cancelTag: tagRequest,
    );
    return ResultModel.fromJson(result);
  }

  static Future<ResultModel> requestLogin({
    String email = "",
    String password = "",
    String tagRequest = HTTPManager.DEFAULT_CANCEL_TAG,
  }) async {
    var params = {"email": email, "password": password, "refreshToken": ""};
    String url = appendBranch(loginUrl);
    final result = await httpManager.post(
      url: url,
      data: params,
      cancelTag: tagRequest,
    );
    return ResultModel.fromJson(result);
  }

  static Future<ResultModel> requestGetMe({
    String tagRequest = HTTPManager.DEFAULT_CANCEL_TAG,
  }) async {
    String url = appendBranch(getMeUrl);

    final result = await httpManager.get(
      url: url,
      cancelTag: tagRequest,
    );
    return ResultModel.fromJson(result);
  }
}
