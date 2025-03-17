import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/preferences.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/enum/text_enum.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/screens/main/profile/widgets/profile_option.dart';
import 'package:ercomerce_app/utils/alert_notification.dart';
import 'package:ercomerce_app/utils/responsive.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late List<Map<String, dynamic>> profileOptions;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileOptions = [
      {
        'title': 'Discount',
        'onPress': _handleNavigateDiscount,
      },
      {
        'title': 'My Discount',
        'onPress': _handleNavigateMyDiscount,
      },
      {
        'title': 'Create Product',
        'onPress': _handleCreateProduct,
      },
      {
        'title': 'Payment',
        'onPress': () {},
      },
      {
        'title': 'Help',
        'onPress': () {},
      },
      {
        'title': 'Logout',
        'onPress': _handleLogOut,
      },
    ];
  }

  void _handleLogOut() {
    UserPreferences.removeAccessToken().then((value) {
      if (value == true) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
      } else {
        showMyDialog(
          context: context,
          onPressed: () {
            Navigator.pop(context);
          },
          content: "Đăng xuất thất bại!",
        );
      }
    });
  }

  void _handleNavigateDiscount() {
    Navigator.pushNamed(context, AppRoutes.discount);
  }

  void _handleNavigateMyDiscount() {
    Navigator.pushNamed(context, AppRoutes.myDiscount);
  }

  void _handleCreateProduct() {
    Navigator.pushNamed(context, AppRoutes.productCreate);
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Gap(16),
            const TextWidget(
              content: "Profiles",
              type: TextType.title,
            ),
            const Gap(16),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final option = profileOptions[index];
                  return ProfileOption(
                      title: option['title'], onPress: option['onPress']);
                },
                itemCount: profileOptions.length,
                separatorBuilder: (context, index) {
                  return const Gap(16);
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
