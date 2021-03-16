import 'package:app/pages/app.dart';
import 'package:app/pages/login.dart';
import 'package:app/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String app = '/';
  static const String login = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SplashScreen()
        );
      case app:
        return PageTransition(child: App(), type: PageTransitionType.fade, duration: Duration(milliseconds: 700));
      case login:
        return PageTransition(child: Login(), type: PageTransitionType.fade, duration: Duration(milliseconds: 700));
      default:
        return null;
    }
  }
}