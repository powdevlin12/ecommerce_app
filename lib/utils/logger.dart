import 'dart:convert';
import 'package:ercomerce_app/configs/application.dart';

class UtilLogger {
  static log([String tag = "", dynamic msg]) {
    if (Application.debug) {
      // developer.log('${msg ?? ''}', name: tag);
      if (msg is Map || msg is List) {
        final prettyString = const JsonEncoder.withIndent('  ').convert(msg);
        print('$tag $prettyString');
      } else {
        print('$tag ${msg ?? ''}');
      }
    }
  }

  ///Singleton factory
  static final _instance = UtilLogger._internal();

  factory UtilLogger() {
    return _instance;
  }

  UtilLogger._internal();
}
