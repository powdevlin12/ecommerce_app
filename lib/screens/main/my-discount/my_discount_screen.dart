import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/discount.model.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/models/service/model_result_pagination_api.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/screens/main/my-discount/widgets/list_my_discount.dart';
import 'package:ercomerce_app/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyDiscountScreen extends StatefulWidget {
  const MyDiscountScreen({super.key});

  @override
  _MyDiscountScreenState createState() => _MyDiscountScreenState();
}

class _MyDiscountScreenState extends State<MyDiscountScreen> {
  StatusState _isLoading = StatusState.init;
  List<DiscountModel> _listDiscount = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  static const int _limit = 10;

  void _onPressBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    _fetchMyDiscount();
    super.initState();
  }

  Future<void> _fetchMyDiscount({bool isLoadMore = false}) async {
    if (_isLoadingMore || (!isLoadMore && _isLoading == StatusState.loading))
      return;

    setState(() {
      if (isLoadMore) {
        _isLoadingMore = true;
      } else {
        _isLoading = StatusState.loading;
      }
    });

    String tagRequestGetDiscount =
        Api.buildIncreaseTagRequestWithID("discount");

    ResultPaginationModel result = await Api.requestGetDiscountOfShop(
      tagRequest: tagRequestGetDiscount,
      page: _currentPage,
      limit: _limit,
    );

    if (result.isSuccess) {
      try {
        List<DiscountModel> listDiscountResult =
            (result.metadata!.data as List).map((item) {
          return DiscountModel.fromJson(item as Map<String, dynamic>);
        }).toList();

        setState(() {
          if (isLoadMore) {
            _listDiscount.addAll(listDiscountResult);
          } else {
            _listDiscount = listDiscountResult;
          }
          _hasMore =
              _currentPage < (result.metadata?.pagination.totalPages ?? 1);
          _currentPage++;
        });
      } catch (e) {
        debugPrint('Lỗi khi ánh xạ dữ liệu: $e');
      }
    } else {
      setState(() {
        if (!isLoadMore) {
          _listDiscount = [];
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
      await _fetchMyDiscount(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.createDiscount);
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
              AppBarWidget(title: "My Discount", onPressBack: _onPressBack),
              const Gap(16),
              Expanded(
                child: ListMyDiscount(
                    listDiscount: _listDiscount,
                    status: _isLoading,
                    onRefresh: () {
                      setState(() {
                        _currentPage = 1;
                        _hasMore = true;
                      });
                      _fetchMyDiscount();
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
