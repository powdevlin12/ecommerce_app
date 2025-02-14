import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/routes/route_type.dart';
import 'package:ercomerce_app/screens/learn/stream_screen.dart';

Map<String, RouteType> learnRoutes = {
  AppRoutes.stream: (context, settings) => const StreamScreen(),
};
