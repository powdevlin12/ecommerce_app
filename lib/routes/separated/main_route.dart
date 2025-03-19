import 'package:ercomerce_app/routes/route_type.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/screens/cart/cart.screen.dart';
import 'package:ercomerce_app/screens/main/category/category_screen.dart';
import 'package:ercomerce_app/screens/main/discount-create/discount_create.screen.dart';
import 'package:ercomerce_app/screens/main/discount/discount_screen.dart';
import 'package:ercomerce_app/screens/main/home/home.dart';
import 'package:ercomerce_app/screens/main/main_screen.dart';
import 'package:ercomerce_app/screens/main/my-discount/my_discount_screen.dart';
import 'package:ercomerce_app/screens/main/product-create/product_create.screen.dart';
import 'package:ercomerce_app/screens/main/product-detail/product_detail.dart';
import 'package:ercomerce_app/screens/main/product-menu/product_menu_screen.dart';

Map<String, RouteType> mainRoutes = {
  AppRoutes.main: (context, settings) => const Main(),
  AppRoutes.home: (context, settings) => const Home(),
  AppRoutes.category: (context, settings) => const CategoryScreen(),
  AppRoutes.discount: (context, settings) => const DiscountScreen(),
  AppRoutes.myDiscount: (context, settings) => const MyDiscountScreen(),
  AppRoutes.productMenu: (context, settings) => const ProductMenuScreen(),
  AppRoutes.productDetail: (context, settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    return ProductDetail(
      productId: args?['productId'],
      from: args?['from'],
    );
  },
  AppRoutes.cart: (context, settings) => const CartScreen(),
  AppRoutes.createDiscount: (context, settings) => const DiscountCreateScreen(),
  AppRoutes.productCreate: (context, settings) => const ProductCreateScreen(),
};
