// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ercomerce_app/utils/parse_type_value.dart';

class DiscountModel {
  final String discountId;
  final String discountName;
  final String discountDescription;
  final String discountType;
  final int discountValue;
  final String discountCode;
  final String discountStartDate;
  final String discountEndDate;
  final int discountMaxUses;
  final int discountUsesCount;
  final List<String> discountUsersUsed;
  final int discountMaxUsesPerUser;
  final int discountMinOverValue;
  final String discountShopId;
  final bool discountIsActive;
  final String discountAppliesTo;
  final List<String> discountProductIds;

  DiscountModel({
    required this.discountId,
    required this.discountName,
    required this.discountDescription,
    required this.discountType,
    required this.discountValue,
    required this.discountCode,
    required this.discountStartDate,
    required this.discountEndDate,
    required this.discountMaxUses,
    required this.discountUsesCount,
    required this.discountUsersUsed,
    required this.discountMaxUsesPerUser,
    required this.discountMinOverValue,
    required this.discountShopId,
    required this.discountIsActive,
    required this.discountAppliesTo,
    required this.discountProductIds,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      discountId: ParseTypeData.ensureString(json["_id"]),
      discountName: ParseTypeData.ensureString(json["discount_name"]),
      discountDescription:
          ParseTypeData.ensureString(json["discount_description"]),
      discountType: ParseTypeData.ensureString(json["discount_type"]),
      discountValue: ParseTypeData.ensureInt(json['discount_value']),
      discountCode: ParseTypeData.ensureString(json["discount_code"]),
      discountStartDate:
          ParseTypeData.ensureString(json["discount_start_date"]),
      discountEndDate: ParseTypeData.ensureString(json["discount_end_date"]),
      discountMaxUses: ParseTypeData.ensureInt(json['discount_max_uses']),
      discountUsesCount: ParseTypeData.ensureInt(json['discount_uses_count']),
      discountUsersUsed:
          ParseTypeData.ensureListString(json['discount_users_used']),
      discountMaxUsesPerUser:
          ParseTypeData.ensureInt(json['discount_max_uses_per_user']),
      discountMinOverValue:
          ParseTypeData.ensureInt(json['discount_min_over_value']),
      discountShopId: ParseTypeData.ensureString(json["discount_shopId"]),
      discountIsActive: ParseTypeData.ensureBool(json["discount_is_active"]),
      discountAppliesTo:
          ParseTypeData.ensureString(json["discount_applies_to"]),
      discountProductIds:
          ParseTypeData.ensureListString(json['discount_product_ids']),
    );
  }

  DiscountModel copyWith({
    String? discountId,
    String? discountName,
    String? discountDescription,
    String? discountType,
    int? discountValue,
    String? discountCode,
    String? discountStartDate,
    String? discountEndDate,
    int? discountMaxUses,
    int? discountUsesCount,
    List<String>? discountUsersUsed,
    int? discountMaxUsesPerUser,
    int? discountMinOverValue,
    String? discountShopId,
    bool? discountIsActive,
    String? discountAppliesTo,
    List<String>? discountProductIds,
  }) {
    return DiscountModel(
      discountId: discountId ?? this.discountId,
      discountName: discountName ?? this.discountName,
      discountDescription: discountDescription ?? this.discountDescription,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      discountCode: discountCode ?? this.discountCode,
      discountStartDate: discountStartDate ?? this.discountStartDate,
      discountEndDate: discountEndDate ?? this.discountEndDate,
      discountMaxUses: discountMaxUses ?? this.discountMaxUses,
      discountUsesCount: discountUsesCount ?? this.discountUsesCount,
      discountUsersUsed: discountUsersUsed ?? this.discountUsersUsed,
      discountMaxUsesPerUser:
          discountMaxUsesPerUser ?? this.discountMaxUsesPerUser,
      discountMinOverValue: discountMinOverValue ?? this.discountMinOverValue,
      discountShopId: discountShopId ?? this.discountShopId,
      discountIsActive: discountIsActive ?? this.discountIsActive,
      discountAppliesTo: discountAppliesTo ?? this.discountAppliesTo,
      discountProductIds: discountProductIds ?? this.discountProductIds,
    );
  }
}
