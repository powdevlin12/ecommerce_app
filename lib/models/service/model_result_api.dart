import 'package:ercomerce_app/utils/parse_type_value.dart';

class ResultModel {
  final bool isSuccess;
  final String message;
  final dynamic metadata;
  dynamic attrs;
  dynamic parent;
  final bool isCancelled;
  final int? statusCode;

  ResultModel(
      {required this.isSuccess,
      required this.message,
      this.isCancelled = false,
      this.metadata,
      this.attrs,
      this.parent,
      this.statusCode});

  factory ResultModel.cancelItem() {
    return ResultModel(
      isSuccess: false,
      message: "",
      isCancelled: true,
    );
  }

  factory ResultModel.empty() {
    return ResultModel(
      isSuccess: false,
      message: "",
    );
  }

  factory ResultModel.fromJson(dynamic jsonObj) {
    if (jsonObj == null) {
      return ResultModel.cancelItem();
    }
    if (jsonObj is! Map<String, dynamic>) {
      return ResultModel.empty();
    }
    Map<String, dynamic> json = jsonObj;

    ResultModel result = ResultModel(
        isSuccess: ParseTypeData.ensureBool(json['isSuccess']),
        message: ParseTypeData.ensureString(
            (json['message'] ?? json['msg']) ?? 'Error'),
        metadata: json.containsKey('metadata') ? json['metadata'] : null,
        attrs: json.containsKey('attrs') ? json['attrs'] : json['attr'],
        parent: json['parent'],
        statusCode: json.containsKey('statusCode') ? json['statusCode'] : null);
    return result;
  }
}
