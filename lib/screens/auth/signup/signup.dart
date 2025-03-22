import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/enum/text_enum.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/utils/alert_notification.dart';
import 'package:ercomerce_app/widgets/back_button_widget.dart';
import 'package:ercomerce_app/widgets/button_widget.dart';
import 'package:ercomerce_app/widgets/screen_widget.dart';
import 'package:ercomerce_app/widgets/text_field_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String tagRequestSignUp = "";
  StatusState _loadingSignUp = StatusState.init;
  bool _isOwnerShop = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, do something
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      tagRequestSignUp = Api.buildIncreaseTagRequestWithID("sign-up");

      setState(() {
        _loadingSignUp = StatusState.loading;
      });

      ResultModel result = _isOwnerShop
          ? await Api.requestSignUp(
              email: email, name: name, password: password)
          : await Api.requestSignUpUser(
              email: email, name: name, password: password);

      if (result.isSuccess) {
        setState(() {
          _loadingSignUp = StatusState.loadCompleted;
        });
        showMyDialog(
            // ignore: use_build_context_synchronously
            context: context,
            onPressed: () {
              Navigator.pop(context);
              // _onGoToLogin();
            },
            content: _isOwnerShop
                ? "Đăng ký chủ shop thành công !"
                : "Đăng ký ngườin dùng thành công !");
      } else {
        setState(() {
          _loadingSignUp = StatusState.loadFailed;
        });
        showMyDialog(
            // ignore: use_build_context_synchronously
            context: context,
            onPressed: () {
              Navigator.pop(context);
            },
            content: result.message);
      }
    }
  }

  void _onGoToLogin() {
    Navigator.pushNamed(
      context,
      AppRoutes.login,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      paddingTop: 28,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              BackButtonWidget(
                onPressed: _onGoToLogin,
              ),
              const SizedBox(height: 16),

              // Title
              const TextWidget(
                content: "Tạo tài khoản",
                type: TextType.title,
              ),
              const SizedBox(height: 32),

              // Form fields
              TextFieldWidget(
                hintText: 'Họ và tên của bạn',
                label: 'Họ và tên của bạn',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Họ và tên không được bỏ trống';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFieldWidget(
                  hintText: 'Nhập địa chỉ email',
                  label: 'Địa chỉ email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Địa chỉ email không được bỏ trống';
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Email không đúng định dạng';
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              TextFieldWidget(
                  hintText: 'Nhập mật khẩu',
                  label: 'Mật khẩu',
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mật khẩu không được bỏ trống';
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              TextFieldWidget(
                  hintText: 'Nhập lại mật khẩu',
                  label: 'Xác nhận mật khẩu',
                  obscureText: true,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        _passwordController.text != value) {
                      return 'Xác nhận mật khẩu không khớp';
                    }
                    return null;
                  }),

              Row(
                children: [
                  const Text('Bạn là chủ shop'),
                  const Gap(12.0),
                  Switch(
                    value: _isOwnerShop,
                    onChanged: (bool value) {
                      setState(() {
                        _isOwnerShop = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Continue button
              ButtonWidget(
                text: 'Đăng ký',
                onPressed: _submitForm,
                isLoading: _loadingSignUp == StatusState.loading,
              ),
              const SizedBox(height: 16),

              // Forgot Password
              Center(
                child: GestureDetector(
                  onTap: _onGoToLogin,
                  child: Text.rich(
                    TextSpan(
                      text: 'Bạn quên mật khẩu? ',
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'Regular'),
                      children: [
                        TextSpan(
                          text: 'Khôi phục ngay',
                          style: TextStyle(
                            color: (primaryColor),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
