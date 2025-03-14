import 'package:ercomerce_app/utils/parse_type_value.dart';

class PaginationInfo {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  PaginationInfo({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      page: ParseTypeData.ensureInt(json['page'] ?? 1),
      limit: ParseTypeData.ensureInt(json['limit'] ?? 10),
      total: ParseTypeData.ensureInt(json['total'] ?? 0),
      totalPages: ParseTypeData.ensureInt(json['totalPages'] ?? 1),
    );
  }
}

class PaginationMetadata {
  final PaginationInfo pagination;
  final dynamic data;

  PaginationMetadata({
    required this.pagination,
    required this.data,
  });

  factory PaginationMetadata.fromJson(Map<String, dynamic> json) {
    return PaginationMetadata(
      pagination: PaginationInfo.fromJson(json['pagination'] ?? {}),
      data: json['data'],
    );
  }
}

class ResultPaginationModel {
  final bool isSuccess;
  final String message;
  final PaginationMetadata? metadata;
  dynamic attrs;
  dynamic parent;
  final bool isCancelled;
  final int? statusCode;

  ResultPaginationModel(
      {required this.isSuccess,
      required this.message,
      this.isCancelled = false,
      this.metadata,
      this.attrs,
      this.parent,
      this.statusCode});

  factory ResultPaginationModel.cancelItem() {
    return ResultPaginationModel(
      isSuccess: false,
      message: "",
      isCancelled: true,
    );
  }

  factory ResultPaginationModel.empty() {
    return ResultPaginationModel(
      isSuccess: false,
      message: "",
    );
  }

  factory ResultPaginationModel.fromJson(dynamic jsonObj) {
    if (jsonObj == null) {
      return ResultPaginationModel.cancelItem();
    }
    if (jsonObj is! Map<String, dynamic>) {
      return ResultPaginationModel.empty();
    }
    Map<String, dynamic> json = jsonObj;

    PaginationMetadata? metadata;
    if (json.containsKey('metadata')) {
      metadata = PaginationMetadata.fromJson(json['metadata']);
    }

    ResultPaginationModel result = ResultPaginationModel(
        isSuccess: ParseTypeData.ensureBool(json['isSuccess']),
        message: ParseTypeData.ensureString(
            (json['message'] ?? json['msg']) ?? 'Error'),
        metadata: metadata,
        attrs: json.containsKey('attrs') ? json['attrs'] : json['attr'],
        parent: json['parent'],
        statusCode: json.containsKey('statusCode') ? json['statusCode'] : null);
    return result;
  }
}
