import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/models/service/model_result_pagination_api.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/screens/main/product-menu/widgets/list_product.dart';
import 'package:ercomerce_app/utils/responsive.dart';
import 'package:ercomerce_app/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductMenuScreen extends StatefulWidget {
  const ProductMenuScreen({super.key});

  @override
  _ProductMenuScreenState createState() => _ProductMenuScreenState();
}

class _ProductMenuScreenState extends State<ProductMenuScreen> {
  StatusState _isLoading = StatusState.init;
  List<ProductModel> _listProduct = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  static const int _limit = 30;

  void _onPressBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    _fetchProducts();
    super.initState();
  }

  Future<void> _fetchProducts({bool isLoadMore = false}) async {
    if (_isLoadingMore || (!isLoadMore && _isLoading == StatusState.loading))
      return;

    setState(() {
      if (isLoadMore) {
        _isLoadingMore = true;
      } else {
        _isLoading = StatusState.loading;
      }
    });

    String tagRequestGetProduct = Api.buildIncreaseTagRequestWithID("product");

    ResultPaginationModel result = await Api.requestGetProductOfShop(
      tagRequest: tagRequestGetProduct,
      page: _currentPage,
      limit: _limit,
    );

    if (result.isSuccess) {
      try {
        List<ProductModel> listProductResult =
            (result.metadata!.data as List).map((item) {
          return ProductModel.fromJson(item as Map<String, dynamic>);
        }).toList();

        setState(() {
          if (isLoadMore) {
            _listProduct.addAll(listProductResult);
          } else {
            _listProduct = listProductResult;
          }
          _hasMore =
              _currentPage < (result.metadata?.pagination.totalPages ?? 1);
          _currentPage++;
        });
      } catch (e) {
        debugPrint('Error mapping data: $e');
      }
    } else {
      setState(() {
        if (!isLoadMore) {
          _listProduct = [];
        }
        _hasMore = false;
      });
    }

    setState(() {
      if (isLoadMore) {
        _isLoadingMore = false;
      } else {
        _isLoading = StatusState.loadCompleted;
      }
    });
  }

  Future<void> _onLoadMore() async {
    if (_hasMore && !_isLoadingMore) {
      await _fetchProducts(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.productCreate);
        },
        backgroundColor: primaryColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: kPaddingHorizontal, right: kPaddingHorizontal),
          child: Column(
            children: [
              AppBarWidget(title: "Product", onPressBack: _onPressBack),
              const Gap(16),
              Expanded(
                child: ListProduct(
                    listProduct: _listProduct,
                    status: _isLoading,
                    onRefresh: () {
                      setState(() {
                        _currentPage = 1;
                        _hasMore = true;
                      });
                      _fetchProducts();
                    },
                    onLoadMore: _onLoadMore,
                    isLoadingMore: _isLoadingMore),
              )
            ],
          ),
        ),
      ),
    );
  }
}
