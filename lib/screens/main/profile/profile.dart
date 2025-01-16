import 'package:ercomerce_app/configs/preferences.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/utils/alert_notification.dart';
import 'package:ercomerce_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ButtonWidget(
            text: "Logout",
            onPressed: () => _handleLogOut(),
          ),
        ),
      ),
    );
  }
}
