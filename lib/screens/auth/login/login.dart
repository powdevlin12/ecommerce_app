import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/blocs/domain/domain_cubit.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/preferences.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/enum/text_enum.dart';
import 'package:ercomerce_app/models/client/login_succes_model.dart';
import 'package:ercomerce_app/models/service/model_result_api.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/utils/alert_notification.dart';
import 'package:ercomerce_app/widgets/button_widget.dart';
import 'package:ercomerce_app/widgets/screen_widget.dart';
import 'package:ercomerce_app/widgets/text_field_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _domainController = TextEditingController();

  final double spacing = 16.0;
  StatusState _loadingLogin = StatusState.init;
  String tagRequestLogin = "";

  void _onGoToRegister() {
    Navigator.pushNamed(
      context,
      AppRoutes.signUp,
    );
  }

  void _onGoToHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  Future<void> _submitForm(String domain) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final domain = _domainController.text;

      tagRequestLogin = Api.buildIncreaseTagRequestWithID("login");

      setState(() {
        _loadingLogin = StatusState.loading;
      });

      await context.read<DomainCubit>().updateDomain(domain);

      final savedDomain = await UserPreferences.getDomain();
      Api.domain = savedDomain;

      ResultModel result =
          await Api.requestLogin(email: email, password: password);

      if (result.isSuccess) {
        LoginSuccess data = LoginSuccess.fromJson(result.metadata);
        await UserPreferences.setAccessToken(data.tokens.accessToken);
        // SharedPreferences sharePreferences =
        //     await SharedPreferences.getInstance();
        // bool isSave = await sharePreferences.setString(
        //     "accessToken", data.tokens.accessToken);

        _onGoToHome();
        setState(() {
          _loadingLogin = StatusState.loadCompleted;
        });
      } else {
        showMyDialog(
            // ignore: use_build_context_synchronously
            context: context,
            onPressed: () {
              Navigator.pop(context);
              // _onGoToLogin();
            },
            content: result.message);
        setState(() {
          _loadingLogin = StatusState.loadFailed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      paddingTop: 68,
      child: BlocBuilder<DomainCubit, String>(builder: (context, domain) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                TextFieldWidget(
                  hintText: 'Nhập tên miền...',
                  controller: _domainController,
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
                  onPressed: () {
                    _submitForm(domain);
                  },
                  isLoading: _loadingLogin == StatusState.loading,
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
          ),
        );
      }),
    );
  }
}
