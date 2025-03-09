import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/cart.model.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/screens/cart/widgets/item_product_cart.dart';
import 'package:ercomerce_app/widgets/app_bar_widget.dart';
import 'package:ercomerce_app/widgets/button_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  StatusState loading = StatusState.init;
  CartModel cart = CartModel.empty();

  final String tagRequestGetListCart =
      Api.buildIncreaseTagRequestWithID("cart");

  Future<ResultModel> _handleGetListCart() async {
    setState(() {
      loading = StatusState.loading;
    });
    ResultModel result =
        await Api.requestGetListCart(tagRequest: tagRequestGetListCart);

    if (result.isSuccess) {
      try {
        CartModel cartProcessing =
            CartModel.fromJson(result.metadata as Map<String, dynamic>);
        setState(() {
          loading = StatusState.loadCompleted;
          cart = cartProcessing;
        });
      } catch (e) {
        debugPrint(e.toString());
        setState(() {
          loading = StatusState.loadFailed;
        });
      }
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    _handleGetListCart();
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
            right: kPaddingHorizontal, left: kPaddingHorizontal),
        child: Column(
          children: [
            AppBarWidget(
              title: "Cart",
              onPressBack: _onBack,
            ),
            const Gap(12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextWidget(
                  content: "Remove all",
                  color: dangerColorToast,
                  weight: FontWeight.w600,
                ),
              ],
            ),
            const Gap(12.0),
            Expanded(
              child: loading == StatusState.loading
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: primaryColor,
                    ))
                  : ListView.separated(
                      itemCount: cart.cart_product.length,
                      separatorBuilder: (context, index) => const Gap(12.0),
                      itemBuilder: (context, index) {
                        final item = cart.cart_product[index];
                        return ItemProductCart(cartProduct: item);
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ButtonWidget(
                text: "Checkout",
                onPressed: () {},
              ),
            )
          ],
        ),
      )),
    );
  }
}
