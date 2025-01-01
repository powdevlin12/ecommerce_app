import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/enum/text_enum.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/widgets/button_widget.dart';
import 'package:ercomerce_app/widgets/screen_widget.dart';
import 'package:ercomerce_app/widgets/text_field_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final double spacing = 16.0;

  void _onGoToRegister() {
    Navigator.pushNamed(
      context,
      AppRoutes.signUp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
        paddingTop: 68,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                content: 'Đăng nhập',
                type: TextType.title,
              ),
              SizedBox(
                height: spacing * 1.5,
              ),
              SizedBox(
                height: spacing,
              ),
              TextFieldWidget(
                hintText: 'Email của bạn',
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email không được bỏ trống';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: spacing,
              ),
              TextFieldWidget(
                  hintText: 'Nhập mật khẩu',
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mật khẩu không được bỏ trống';
                    }
                    return null;
                  }),
              SizedBox(
                height: spacing,
              ),
              ButtonWidget(
                text: 'Đăng nhập',
                onPressed: () {},
                isLoading: false,
              ),
              SizedBox(
                height: spacing,
              ),
              GestureDetector(
                onTap: _onGoToRegister,
                child: Row(
                  children: [
                    const TextWidget(
                      content: 'Bạn chưa có tài khoản?',
                      size: 14.0,
                      weight: FontWeight.w500,
                    ),
                    TextWidget(
                      content: ' Đăng ký tại đây',
                      size: 14.0,
                      weight: FontWeight.w500,
                      color: primaryColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
