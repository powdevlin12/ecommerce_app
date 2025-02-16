import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/blocs/product/product_bloc.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/screens/main/home/widgets/product_item.dart';
import 'package:ercomerce_app/utils/alert_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ProductBloc productBloc;
  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context, listen: false);

    if (productBloc.state.productState != StatusState.loadCompleted) {
      _handleGetPublishProduct();
    }
  }

  Future<ResultModel> _handleGetPublishProduct() async {
    productBloc.add(
        const OnUpdateStatus(params: {"productStatus": StatusState.loading}));

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

        productBloc.add(
            OnUpdateListProduct(params: {"listProduct": listProductResult}));

        productBloc.add(const OnUpdateStatus(
            params: {"productStatus": StatusState.loadCompleted}));
      } catch (e) {
        productBloc.add(const OnUpdateStatus(
            params: {"productStatus": StatusState.loadFailed}));
        debugPrint('Lỗi khi ánh xạ dữ liệu: $e');
      }
    } else {
      if (mounted && context.mounted) {
        showMyDialog(
            context: context,
            onPressed: () {
              Navigator.pop(context);
            },
            title: "Thông báo",
            content: "Lấy thông tin sản phẩm thất bại");
      }
    }
    return result;
  }

  Widget handleBuidList(
      {required List<ProductModel> listProduct, required StatusState status}) {
    if (status != StatusState.loadCompleted) {
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
      backgroundColor: backgroundColor,
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          debugPrint('state ${state.productState}');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: handleBuidList(
                status: state.productState, listProduct: state.listProduct),
          );
        },
      ),
    );
  }
}
