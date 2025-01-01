import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
