import 'package:app/routes/router.dart';
import 'package:app/state/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (context) => AuthState(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafetyOU',
      themeMode: ThemeMode.system, //Utilitza el tema del sistema
      // Més endevant podem controlar amb una variable si l'usuari ho canvia des de l'aplicació
      theme: ThemeData(),
      darkTheme: ThemeData(),

      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
