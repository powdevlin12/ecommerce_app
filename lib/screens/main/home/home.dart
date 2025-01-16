import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/screens/main/home/widgets/product_item.dart';
import 'package:ercomerce_app/utils/alert_notification.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ProductModel> listProduct = [];
  bool loading = false;

  Future<ResultModel> _handleGetPublishProduct() async {
    setState(() {
      loading = true;
    });
    String tagRequestGetPublishProduct =
        Api.buildIncreaseTagRequestWithID("product");

    ResultModel result = await Api.requestGetPublishProduct(
        tagRequest: tagRequestGetPublishProduct);

    if (result.isSuccess) {
      try {
        List<ProductModel> listProductResult =
            (result.metadata as List).map((item) {
          return ProductModel.fromJson(item as Map<String, dynamic>);
        }).toList();
        setState(() {
          listProduct = listProductResult;
          loading = false;
        });
      } catch (e) {
        setState(() {
          loading = false;
        });
        debugPrint('Lỗi khi ánh xạ dữ liệu: $e');
      }
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

  Widget handleBuidList() {
    if (loading) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator(color: primaryColor)),
      );
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Số cột
        crossAxisSpacing: 10.0, // Khoảng cách giữa các cột
        mainAxisSpacing: 10.0, // Khoảng cách giữa các hàng
        childAspectRatio: 0.7, // Tỉ lệ chiều rộng / chiều cao của ô
      ),
      itemCount: listProduct.length,
      itemBuilder: (context, index) {
        return ProductItem(product: listProduct[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: handleBuidList(),
      ),
    );
  }
}
