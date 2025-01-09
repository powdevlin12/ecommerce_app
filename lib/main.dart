import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/blocs/domain/domain_cubit.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/preferences.dart';
import 'package:ercomerce_app/models/service/shop_model.dart';
import 'package:ercomerce_app/repository/shop_repository.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => DomainCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initPreferences().then((value) {
      _initDomain();
    }).then((value) {
      _initGetAccessToken();
    }).then((value) {
      _initGetShop();
    });
  }

  Future<void> _initDomain() async {
    final domain = await UserPreferences.getDomain();
    Api.domain = domain;
  }

  Future<void> _initGetAccessToken() async {
    final accessToken = await UserPreferences.getAccessToken();
    Api.accessToken = accessToken;
  }

  Future<void> _initGetShopId() async {
    final shopId = await UserPreferences.getShopId();
    Api.shopId = shopId;
  }

  Future<ShopModel> _initGetShop() async {
    final shop = await UserPreferences.getShop();
    ShopRepository.setUserModel(shop.toJson());
    return shop;
  }

  Future<void> _initPreferences() async {
    await Preferences.setPreferences();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: Routes.onGenerateRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
