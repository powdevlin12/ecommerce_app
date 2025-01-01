import 'package:ercomerce_app/api/http_manager.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';

class Api {
  static final httpManager = HTTPManager();
  static const String https = "https://";
  static const String http = "http://";

  static String getProtocol() {
    const bool useSsl = false;
    String protocol = (useSsl ? Api.https : Api.http);
    return protocol;
  }

  static String localHost() {
    // return "restaurantbe-production.up.railway.app";
    return "172.16.2.6:3012";
  }

  static String branchGetter() {
    String branch = getProtocol() + localHost();
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

  static Future<ResultModel> requestSignUp({
    String email = "",
    String name = "",
    String password = "",
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
}
