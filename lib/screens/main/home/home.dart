import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/preferences.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/utils/alert_notification.dart';
import 'package:ercomerce_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _handleLogOut() {
    UserPreferences.removeAccessToken().then((value) {
      if (value == true) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
      } else {
        showMyDialog(
          context: context,
          onPressed: () {
            Navigator.pop(context);
          },
          content: "Đăng xuất thất bại!",
        );
      }
    });
  }

  Future<ResultModel> _handleGetPublishProduct() async {
    String tagRequestGetPublishProduct =
        Api.buildIncreaseTagRequestWithID("product");

    ResultModel result = await Api.requestGetPublishProduct(
        tagRequest: tagRequestGetPublishProduct);

    if (result.isSuccess) {
      // ignore: unused_local_variable
      List<ProductModel> listProduct = result.metadata
          .map((item) {
            return ProductModel.fromJson(item as Map<String, dynamic>);
          })
          .toList()
          .cash<ProductModel>();
    } else {
      showMyDialog(
          context: context,
          onPressed: () {
            Navigator.pop(context);
          },
          title: "Thông báo",
          content: "Lấy thông tin sản phẩm thất bại");
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    _handleGetPublishProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ButtonWidget(
          text: "Logout",
          onPressed: () => _handleLogOut(),
        ),
      ),
    );
  }
}
