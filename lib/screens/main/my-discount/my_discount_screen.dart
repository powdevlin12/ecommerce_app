import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/discount.model.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
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

  void _onPressBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    _fetchMyDiscount();
    super.initState();
  }

  Future<void> _fetchMyDiscount() async {
    setState(() {
      _isLoading = StatusState.loading;
    });

    String tagRequestGetDiscount =
        Api.buildIncreaseTagRequestWithID("discount");

    ResultModel result =
        await Api.requestGetDiscountOfShop(tagRequest: tagRequestGetDiscount);

    if (result.isSuccess) {
      try {
        List<DiscountModel> listDiscountResult =
            (result.metadata as List).map((item) {
          return DiscountModel.fromJson(item as Map<String, dynamic>);
        }).toList();
        setState(() {
          _listDiscount = listDiscountResult;
        });
      } catch (e) {
        debugPrint('Lỗi khi ánh xạ dữ liệu: $e');
      }
    } else {
      setState(() {
        _listDiscount = [];
      });
    }

    setState(() {
      _isLoading = StatusState.loadCompleted;
    });

    // Gọi API tìm kiếm (dưới đây là giả lập)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: kPaddingHorizontal, right: kPaddingHorizontal, top: 16.0),
          child: Column(
            children: [
              const Gap(8),
              AppBarWidget(title: "My Discount", onPressBack: _onPressBack),
              const Gap(16),
              Expanded(
                child: ListMyDiscount(
                    listDiscount: _listDiscount, status: _isLoading),
              )
            ],
          ),
        ),
      ),
    );
  }
}
