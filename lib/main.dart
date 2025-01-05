import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/blocs/domain/domain_cubit.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/preferences.dart';
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
    _initPreferences();
    _initDomain();
  }

  Future<void> _initDomain() async {
    final domain = await UserPreferences.getDomain();
    Api.domain = domain;
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
      initialRoute: AppRoutes.login,
      onGenerateRoute: Routes.onGenerateRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
