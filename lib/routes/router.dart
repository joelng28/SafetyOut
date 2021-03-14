import 'package:app/pages/app.dart';
import 'package:app/pages/login.dart';
//import 'package:app/state/auth.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class AppRouter {
  static const String home = '/';
  static const String login = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => /*Provider.of<AuthState>(context).logInState ?*/ App() /*: Login()*/
        );
      case login:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Login()
        );
      default:
        return null;
    }
  }
}