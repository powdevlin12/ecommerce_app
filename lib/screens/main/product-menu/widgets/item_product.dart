import 'package:cached_network_image/cached_network_image.dart';
import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/utils/format.dart';
import 'package:ercomerce_app/utils/responsive.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ItemProduct extends StatelessWidget {
  final ProductModel product;
  final Function() onRefresh;

  final double sizeText = Responsive.scale(18);
  ItemProduct({super.key, required this.product, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: Container(
        decoration: BoxDecoration(
          color: subBgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.scale(12), vertical: Responsive.scale(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: product.product_thumb!,
              height: Responsive.scale(60),
              width: Responsive.scale(60),
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextWidget(
                          content: product.product_name,
                          maxLines: 3,
                        ),
                      ),
                      const Gap(8),
                      TextWidget(
                        content: 'x${product.product_quantity}',
                        color: blueColor,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        content:
                            "Status: ${product.is_public ? "Public" : "Draft"}",
                        align: TextAlign.start,
                      ),
                      TextWidget(
                        content: formatCurrency(product.product_price! * 1.0),
                        align: TextAlign.start,
                        weight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ],
                  )
                ],
              ),
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
          padding: EdgeInsets.symmetric(vertical: Responsive.scale(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  child: TextWidget(
                    content: "Chi tiết",
                    weight: FontWeight.w600,
                    align: TextAlign.center,
                    size: sizeText,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.productDetail,
                        arguments: {
                          'productId': product.productId,
                          'from': 'menu'
                        }); // Đóng bottom sheet
                    // _confirmUpdateDiscountStatus(context);
                  },
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  child: TextWidget(
                    content: product.is_public ? "Lữu trữ" : "Công khai",
                    weight: FontWeight.w600,
                    align: TextAlign.center,
                    size: sizeText,
                  ),
                  onTap: () {
                    Navigator.pop(context); // Đóng bottom sheet
                    _confirmUpdateProductStatus(context);
                  },
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  child: TextWidget(
                    content: "Xóa",
                    weight: FontWeight.w600,
                    align: TextAlign.center,
                    size: sizeText,
                    color: dangerColorToast,
                  ),
                  onTap: () {
                    Navigator.pop(context); // Đóng bottom sheet
                    // _confirmDeleteDiscount(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmUpdateProductStatus(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: const Text("Xác nhận"),
          content: Text(product.is_public
              ? "Bạn có chắc chắn muốn lữu trữ '${product.product_name}'?"
              : "Bạn có chắc chắn muốn công khai '${product.product_name}'?"),
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
                _updateProductStatus(context);
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

  Future<void> _updateProductStatus(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    String tagRequest = Api.buildIncreaseTagRequestWithID("update_product");

    try {
      ResultModel result = await Api.requestUpdateProductStatus(
          productId: product.productId,
          tagRequest: tagRequest,
          isPublic: product.is_public);

      if (result.isSuccess) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(!product.is_public
                ? "Công khai ${product.product_name} thành công"
                : "Lưu trữ ${product.product_name} thành công"),
          ),
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
