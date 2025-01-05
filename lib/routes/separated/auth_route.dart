import 'package:ercomerce_app/routes/route_type.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/screens/auth/login/login.dart';
import 'package:ercomerce_app/screens/auth/signup/signup.dart';

Map<String, RouteType> authRoutes = {
  AppRoutes.login: (context, settings) => const Login(),
  AppRoutes.signUp: (context, settings) => const Signup(),
};
