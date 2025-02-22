import 'dart:async';

import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/screens/main/discount/widgets/discount_empty.dart';
import 'package:ercomerce_app/screens/main/home/widgets/product_list.dart';
import 'package:ercomerce_app/widgets/app_bar_widget.dart';
import 'package:ercomerce_app/widgets/back_button_widget.dart';
import 'package:ercomerce_app/widgets/search_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  @override
  _DiscountScreenState createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  final TextEditingController searchController = TextEditingController();
  List<ProductModel> _listProduct = [];
  Timer? _debounceTimer; // Timer để debounce
  StatusState _isLoading = StatusState.init;

  @override
  void dispose() {
    searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _fetchSearchResults(searchController.text);
    });
  }

  Future<void> _fetchSearchResults(String query) async {
    if (query.isEmpty) return;
    debugPrint(query);
    setState(() {
      _isLoading = StatusState.loading;
    });

    String tagRequestGetProduct = Api.buildIncreaseTagRequestWithID("product");

    ResultModel result = await Api.requestGetProductBelongToCode(
        tagRequest: tagRequestGetProduct, code: query);

    if (result.isSuccess) {
      try {
        List<ProductModel> listCategoryResult =
            (result.metadata as List).map((item) {
          return ProductModel.fromJson(item as Map<String, dynamic>);
        }).toList();
        setState(() {
          _listProduct = listCategoryResult;
        });
      } catch (e) {
        debugPrint('Lỗi khi ánh xạ dữ liệu: $e');
      }
    } else {
      setState(() {
        _listProduct = [];
      });
    }

    setState(() {
      _isLoading = StatusState.loadCompleted;
    });

    // Gọi API tìm kiếm (dưới đây là giả lập)
  }

  void _onBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: kPaddingHorizontal, right: kPaddingHorizontal, top: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarWidget(title: "Discount", onPressBack: _onBack),
              const Gap(16.0),
              SearchWidget(
                controller: searchController,
                onChanged: _onSearchChanged,
              ),
              const Gap(16),
              _listProduct.isEmpty
                  ? Center(
                      child: DiscountEmpty(
                        content: _isLoading == StatusState.loadCompleted
                            ? "Discount not found!!!"
                            : "Please type discount to search product apply!",
                      ),
                    )
                  : ProductList(
                      listProduct: _listProduct,
                      status: _isLoading,
                      title: "Product with code apply discount",
                    )
            ],
          ),
        ),
      ),
    );
  }
}
