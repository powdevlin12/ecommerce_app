import 'dart:io';

import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/blocs/category/category_bloc.dart';
import 'package:ercomerce_app/blocs/product/product_bloc.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/category.model.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/screens/main/home/widgets/app_bar_home.dart';
import 'package:ercomerce_app/screens/main/home/widgets/category_home.dart';
import 'package:ercomerce_app/screens/main/home/widgets/product_list.dart';
import 'package:ercomerce_app/utils/alert_notification.dart';
import 'package:ercomerce_app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ProductBloc productBloc;
  late CategoryBloc categoryBloc;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context, listen: false);
    categoryBloc = BlocProvider.of<CategoryBloc>(context, listen: false);

    if (productBloc.state.productState != StatusState.loadCompleted) {
      _handleGetPublishProduct();
    }

    if (categoryBloc.state.categoryState != StatusState.loadCompleted) {
      _handleGetCategories();
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

  Future<ResultModel> _handleGetCategories() async {
    categoryBloc.add(const OnUpdateStatusCategory(
        params: {"categoryState": StatusState.loading}));

    String tagRequestGetCattegories =
        Api.buildIncreaseTagRequestWithID("category");

    ResultModel result =
        await Api.requestGetCategories(tagRequest: tagRequestGetCattegories);

    if (result.isSuccess) {
      try {
        List<CategoryModel> listCategoryResult =
            (result.metadata as List).map((item) {
          return CategoryModel.fromJson(item as Map<String, dynamic>);
        }).toList();

        categoryBloc.add(OnUpdateListCategory(
            params: {"listCategoryArg": listCategoryResult}));

        categoryBloc.add(const OnUpdateStatusCategory(
            params: {"categoryState": StatusState.loadCompleted}));
      } catch (e) {
        categoryBloc.add(const OnUpdateStatusCategory(
            params: {"categoryState": StatusState.loadFailed}));
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
            content: "Lấy thông tin danh mục thất bại");
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          top: true,
          child: Column(
            children: [
              SizedBox(
                height: Platform.isAndroid ? 32 : 8,
              ),
              const AppBarHome(),
              const Gap(16.0),
              Expanded(
                  child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPaddingHorizontal),
                    child: SearchWidget(
                      controller: controller,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BlocConsumer<CategoryBloc, CategoryState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return CategoryHome(
                          listCategory: state.listCategory,
                          status: state.categoryState,
                        );
                      }),
                  const SizedBox(height: 8),
                  BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      debugPrint('state ${state.productState}');
                      return RefreshIndicator(
                        onRefresh: _handleGetPublishProduct,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPaddingHorizontal),
                          child: ProductList(
                              listProduct: state.listProduct,
                              status: state.productState),
                        ),
                      );
                    },
                  ),
                ],
              ))
            ],
          )),
    );
  }
}
