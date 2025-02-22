import 'package:ercomerce_app/routes/route_type.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/screens/main/category/category_screen.dart';
import 'package:ercomerce_app/screens/main/discount/discount_screen.dart';
import 'package:ercomerce_app/screens/main/home/home.dart';
import 'package:ercomerce_app/screens/main/main_screen.dart';

Map<String, RouteType> mainRoutes = {
  AppRoutes.main: (context, settings) => const Main(),
  AppRoutes.home: (context, settings) => const Home(),
  AppRoutes.category: (context, settings) => const CategoryScreen(),
  AppRoutes.discount: (context, settings) => const DiscountScreen(),
};
