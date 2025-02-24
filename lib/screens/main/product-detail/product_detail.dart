import 'package:cached_network_image/cached_network_image.dart';
import 'package:ercomerce_app/blocs/product/product_bloc.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/utils/format.dart';
import 'package:ercomerce_app/widgets/app_bar_widget.dart';
import 'package:ercomerce_app/widgets/button_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProductDetail extends StatefulWidget {
  final String productId;
  const ProductDetail({super.key, required this.productId, required});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late ProductBloc productBloc;
  late ProductModel productDetail;
  void _onBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context, listen: false);
    setState(() {
      productDetail = productBloc.state.listProduct
          .firstWhere((product) => product.productId == widget.productId);
    });
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarWidget(
                title: "Product detail",
                onPressBack: _onBack,
                rightActionWidget: const Icon(
                  Icons.heart_broken_outlined,
                  size: 28.0,
                ),
              ),
              const Gap(16.0),
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 248,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        child: CachedNetworkImage(
                          imageUrl: productDetail.product_thumb,
                          // height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const Gap(16.0),
                    TextWidget(
                      content: productDetail.product_name,
                      weight: FontWeight.bold,
                    ),
                    const Gap(8.0),
                    TextWidget(
                      content:
                          formatCurrency(productDetail.product_price * 1.0),
                      color: primaryColor,
                      weight: FontWeight.bold,
                    ),
                    const Gap(8.0),
                    TextWidget(
                      content: productDetail.product_description,
                      color: subTextColor,
                      size: 14.0,
                    )
                  ],
                ),
              ),
              ButtonWidget(text: "Add To Card", onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
