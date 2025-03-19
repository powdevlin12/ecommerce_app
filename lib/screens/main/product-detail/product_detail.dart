import 'package:cached_network_image/cached_network_image.dart';
import 'package:ercomerce_app/blocs/product/product_bloc.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/screens/main/product-detail/widgets/product_quantity.dart';
import 'package:ercomerce_app/screens/main/product-detail/widgets/product_variations.dart';
import 'package:ercomerce_app/utils/alert_notification.dart';
import 'package:ercomerce_app/utils/format.dart';
import 'package:ercomerce_app/utils/responsive.dart';
import 'package:ercomerce_app/widgets/app_bar_widget.dart';
import 'package:ercomerce_app/widgets/button_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProductDetail extends StatefulWidget {
  final String productId;
  final String? from;
  const ProductDetail({super.key, required this.productId, this.from});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late ProductBloc productBloc;
  late ProductModel productDetail;
  int quantity = 1;
  late String variantions;

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
      variantions = productDetail.product_variations?.isNotEmpty == true
          ? productDetail.product_variations!.first
          : "No variations";
    });
  }

  void _onMinus() {
    debugPrint("minus");
    if (quantity >= 2) {
      setState(() {
        quantity = quantity - 1;
      });
    } else {
      showMyDialog(
          context: context,
          onPressed: () {
            Navigator.pop(context);
          },
          content: "Không thể giảm số lượng nữa!");
    }
  }

  void _onPlus() {
    setState(() {
      quantity = quantity + 1;
    });
  }

  void _handleSelectVariation(String value) {
    setState(() {
      variantions = value;
    });
  }

  void _handleShowBottomSheetSelectVariations() {
    showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        backgroundColor: backgroundColor,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            String localVariantion = variantions;
            return SizedBox(
              height: 300,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    const Gap(12),
                    TextWidget(
                      content: "Variations",
                      size: Responsive.scale(18),
                      weight: FontWeight.bold,
                    ),
                    const Gap(12),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Gap(16),
                        itemBuilder: (context, index) {
                          String curretVariantions =
                              productDetail.product_variations?[index] ??
                                  "No data";
                          return InkWell(
                            onTap: () => {
                              _handleSelectVariation(curretVariantions),
                              setState(() {
                                localVariantion = curretVariantions;
                              })
                            },
                            child: Container(
                              height: Responsive.scale(56),
                              decoration: BoxDecoration(
                                  color: curretVariantions == localVariantion
                                      ? primaryColor
                                      : subBgColor,
                                  borderRadius: BorderRadius.circular(24.0)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPaddingHorizontal,
                                  vertical: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextWidget(
                                    content: curretVariantions,
                                    weight: FontWeight.bold,
                                    color: curretVariantions == localVariantion
                                        ? Colors.white
                                        : textColor,
                                  ),
                                  if (curretVariantions == localVariantion)
                                    SvgPicture.asset(
                                      "assets/check.svg",
                                      width: Responsive.scale(28),
                                      height: Responsive.scale(28),
                                    )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount:
                            productDetail.product_variations?.length ?? 0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
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
                rightActionWidget: Icon(
                  Icons.heart_broken_outlined,
                  size: Responsive.scale(24),
                ),
              ),
              const Gap(16.0),
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: Responsive.scale(248),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        child: CachedNetworkImage(
                          imageUrl: productDetail.product_thumb!,
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
                          formatCurrency(productDetail.product_price! * 1.0),
                      color: primaryColor,
                      weight: FontWeight.bold,
                    ),
                    const Gap(8.0),
                    ProductQuantity(
                      quantity: quantity,
                      onMinus: _onMinus,
                      onPlus: _onPlus,
                    ),
                    const Gap(16),
                    ProductVariations(
                        variationActive: variantions,
                        onPressSelect: _handleShowBottomSheetSelectVariations),
                    const Gap(8.0),
                    TextWidget(
                      content: productDetail.product_description,
                      color: subTextColor,
                      size: Responsive.scale(14),
                    )
                  ],
                ),
              ),
              if (widget.from != "menu")
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ButtonWidget(
                    text: "Add To Card",
                    onPressed: () {},
                    leftWidget: TextWidget(
                        size: Responsive.scale(18),
                        weight: FontWeight.bold,
                        color: Colors.white,
                        content: formatCurrency(
                            (quantity * productDetail.product_price!) * 1.0)),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
