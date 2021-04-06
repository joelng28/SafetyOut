import 'package:app/pages/app.dart';
import 'package:app/pages/login.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String app = '/';
  static const String login = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case app:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => App());
        break;
      case login:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Login());
        break;

      default:
        return null;
    }
  }
}
