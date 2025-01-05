import 'package:ercomerce_app/routes/route_type.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/screens/main/home/home.dart';

Map<String, RouteType> mainRoutes = {
  AppRoutes.home: (context, settings) => const Home(),
};
