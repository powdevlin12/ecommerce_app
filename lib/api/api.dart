import 'package:ercomerce_app/api/http_manager.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/models/service/model_result_pagination_api.dart';

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
  static String getPublishProduct = "$versionApi/products/publish/all";
  static String getListCategoryUrl = "$versionApi/category";
  static String getListProductBelongToCodeUrl =
      "$versionApi/discount/get-discount-belongto-code";
  // discount
  static String getListMyDiscount = "$versionApi/discount/get-discount-shop";
  static String discount = "$versionApi/discount";

  // cart
  static String getListCartUrl = "$versionApi/cart";

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

  // ** Product
  static Future<ResultModel> requestGetPublishProduct({
    String tagRequest = HTTPManager.DEFAULT_CANCEL_TAG,
  }) async {
    String url = appendBranch(getPublishProduct);

    final result = await httpManager.get(
      url: url,
      cancelTag: tagRequest,
    );
    return ResultModel.fromJson(result);
  }

// ** Categories
  static Future<ResultModel> requestGetCategories({
    String tagRequest = HTTPManager.DEFAULT_CANCEL_TAG,
  }) async {
    String url = appendBranch(getListCategoryUrl);

    final result = await httpManager.get(
      url: url,
      cancelTag: tagRequest,
    );
    return ResultModel.fromJson(result);
  }

// ** Discount
  static Future<ResultModel> requestGetProductBelongToCode(
      {String tagRequest = HTTPManager.DEFAULT_CANCEL_TAG,
      String code = ""}) async {
    String url =
        appendBranch("$getListProductBelongToCodeUrl/$code?limit=5&page=1");

    final result = await httpManager.get(
      url: url,
      cancelTag: tagRequest,
    );
    return ResultModel.fromJson(result);
  }

  static Future<ResultPaginationModel> requestGetDiscountOfShop(
      {String tagRequest = HTTPManager.DEFAULT_CANCEL_TAG,
      int page = 1,
      int limit = 10}) async {
    String url = appendBranch("$getListMyDiscount?page=$page&limit=$limit");

    final result = await httpManager.get(
      url: url,
      cancelTag: tagRequest,
    );
    return ResultPaginationModel.fromJson(result);
  }

  static Future<ResultModel> requestGetListCart(
      {String tagRequest = HTTPManager.DEFAULT_CANCEL_TAG}) async {
    String url = appendBranch(getListCartUrl);

    final result = await httpManager.get(
      url: url,
      cancelTag: tagRequest,
    );
    return ResultModel.fromJson(result);
  }

  static Future<ResultModel> requestCreateDiscount({
    required String name,
    required String description,
    required String type,
    required double value,
    required String code,
    required String startDate,
    required String endDate,
    required int maxUses,
    required int maxUsesPerUser,
    required double minOrderValue,
    required bool isActive,
    required String appliesTo,
    List<String> productIds = const [],
    String tagRequest = HTTPManager.DEFAULT_CANCEL_TAG,
  }) async {
    Map<String, dynamic> params = {
      "discount_name": name,
      "discount_description": description,
      "discount_type": type,
      "discount_value": value,
      "discount_code": code,
      "discount_start_date": startDate,
      "discount_end_date": endDate,
      "discount_max_uses": maxUses,
      "discount_uses_count": 0,
      "discount_max_uses_per_user": maxUsesPerUser,
      "discount_min_over_value": minOrderValue,
      "discount_is_active": isActive,
      "discount_applies_to": appliesTo,
      "discount_product_ids": productIds,
    };

    String url = appendBranch(discount);
    final result = await httpManager.post(
      url: url,
      data: params,
      cancelTag: tagRequest,
    );
    return ResultModel.fromJson(result);
  }

  static Future<ResultModel> requestDeleteDiscount({
    required String discountId,
    String tagRequest = HTTPManager.DEFAULT_CANCEL_TAG,
  }) async {
    String url = appendBranch("$discount/$discountId");
    final result = await httpManager.delete(
      url: url,
      cancelTag: tagRequest,
    );
    return ResultModel.fromJson(result);
  }

  static Future<ResultModel> requestUpdateDiscountStatus({
    required String discountId,
    required bool isActive,
    String tagRequest = HTTPManager.DEFAULT_CANCEL_TAG,
  }) async {
    Map<String, dynamic> params = {
      "discount_id": discountId,
      "discount_is_active": isActive,
    };

    String url = appendBranch(discount);
    final result = await httpManager.patch(
      url: url,
      data: params,
      cancelTag: tagRequest,
    );
    return ResultModel.fromJson(result);
  }
}
