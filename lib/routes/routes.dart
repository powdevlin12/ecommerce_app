import 'package:ercomerce_app/routes/route_type.dart';
import 'package:ercomerce_app/routes/separated/auth_route.dart';
import 'package:ercomerce_app/routes/separated/learn_route.dart';
import 'package:ercomerce_app/routes/separated/main_route.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, RouteType> _resolveRoutes() {
    return {...authRoutes, ...mainRoutes, ...learnRoutes};
  }

  static Route onGenerateRoutes(RouteSettings settings) {
    var routes = _resolveRoutes();
    try {
      final child = routes[settings.name];

      Widget builder(BuildContext c) => child!(c, settings);

      // if (settings.name == AppRoutes.login) {
      //   return SlideRoute(builder: builder);
      // }

      return MaterialPageRoute(
        builder: builder,
      );
    } catch (e) {
      throw const FormatException("--- Route doesn't exist");
    }
  }
}
