import 'package:ercomerce_app/blocs/category/category_bloc.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/text_enum.dart';
import 'package:ercomerce_app/screens/main/category/widgets/category_list.dart';
import 'package:ercomerce_app/widgets/back_button_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryBloc categoryBloc;

  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of<CategoryBloc>(context, listen: false);
  }

  void _onBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                BackButtonWidget(
                  onPressed: _onBack,
                ),
                const Gap(16),
                const TextWidget(
                  content: "Shop by Categories",
                  type: TextType.title,
                ),
                const Gap(16),
                BlocConsumer<CategoryBloc, CategoryState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Column(
                        children: [
                          CategoryList(
                            listCategory: state.listCategory,
                            status: state.categoryState,
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
