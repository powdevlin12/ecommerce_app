import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/models/product/discount.model.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/utils/format.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ItemMyDiscount extends StatelessWidget {
  final DiscountModel discount;
  final Function() onRefresh;

  const ItemMyDiscount(
      {super.key, required this.discount, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kPaddingHorizontal, vertical: 16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            color: subBgColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(
                  content: discount.discountName,
                  weight: FontWeight.w500,
                ),
                Icon(
                  Icons.adjust_rounded,
                  color:
                      discount.discountIsActive ? greenColor : dangerColorToast,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  content: discount.discountCode,
                  weight: FontWeight.bold,
                ),
                TextWidget(
                  content: "Max user use ${discount.discountMaxUses}",
                  size: 14.0,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  content: "User used : ${discount.discountUsersUsed.length}",
                  size: 14,
                ),
                TextWidget(
                  content:
                      "Amount of product apply : ${discount.discountProductIds.length}",
                  size: 14,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  content: "Start: ${formatDate(discount.discountStartDate)}",
                  size: 14.0,
                ),
                TextWidget(
                  content: "End: ${formatDate(discount.discountEndDate)}",
                  size: 14.0,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const TextWidget(
                  content: "Chi tiết",
                  size: 18.0,
                  weight: FontWeight.w600,
                  align: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pop(context); // Đóng bottom sheet
                  _confirmUpdateDiscountStatus(context);
                },
              ),
              const Divider(),
              ListTile(
                title: TextWidget(
                  content:
                      discount.discountIsActive ? "Vô hiệu hóa" : "Kích hoạt",
                  size: 18.0,
                  weight: FontWeight.w600,
                  align: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pop(context); // Đóng bottom sheet
                  _confirmUpdateDiscountStatus(context);
                },
              ),
              const Divider(),
              ListTile(
                title: TextWidget(
                  content: "Xóa",
                  color: dangerColorToast,
                  size: 18.0,
                  weight: FontWeight.w600,
                  align: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pop(context); // Đóng bottom sheet
                  _confirmDeleteDiscount(context);
                },
                contentPadding: const EdgeInsets.only(bottom: 16.0, left: 16.0),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmDeleteDiscount(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xác nhận"),
          content: Text(
              "Bạn có chắc chắn muốn xóa discount '${discount.discountName}'?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteDiscount(context);
              },
              child: Text(
                "Xóa",
                style: TextStyle(color: dangerColorToast),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmUpdateDiscountStatus(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: const Text("Xác nhận"),
          content: Text(discount.discountIsActive
              ? "Bạn có chắc chắn muốn vô hiệu hóa discount '${discount.discountName}'?"
              : "Bạn có chắc chắn muốn kích hoạt discount '${discount.discountName}'?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const TextWidget(
                content: "Hủy",
                weight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _updateDiscountStatus(context);
              },
              child: TextWidget(
                content: "Xác nhận",
                color: primaryColor,
                weight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteDiscount(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    String tagRequest = Api.buildIncreaseTagRequestWithID("delete_discount");

    try {
      ResultModel result = await Api.requestDeleteDiscount(
        discountId: discount.discountId,
        tagRequest: tagRequest,
      );

      if (result.isSuccess) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Xóa discount thành công")),
        );
        onRefresh();
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text("Lỗi: ${result.message}")),
        );
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text("Đã xảy ra lỗi: $e")),
      );
    }
  }

  Future<void> _updateDiscountStatus(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    String tagRequest = Api.buildIncreaseTagRequestWithID("update_discount");

    try {
      ResultModel result = await Api.requestUpdateDiscountStatus(
        discountId: discount.discountId,
        isActive: !discount.discountIsActive,
        tagRequest: tagRequest,
      );

      if (result.isSuccess) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
              content: Text(discount.discountIsActive
                  ? "Vô hiệu hóa discount thành công"
                  : "Kích hoạt discount thành công")),
        );
        onRefresh();
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text("Lỗi: ${result.message}")),
        );
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text("Đã xảy ra lỗi: $e")),
      );
    }
  }
}
