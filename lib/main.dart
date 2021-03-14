import 'package:app/app_localizations.dart';
import 'package:app/routes/router.dart';
import 'package:app/state/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      title: 'SafetyOUT',
      themeMode: ThemeMode.system, //Uses default system theme
      // Més endevant podem controlar amb una variable si l'usuari ho canvia des de l'aplicació
      theme: ThemeData(),
      darkTheme: ThemeData(),

      supportedLocales: [
        Locale('en', ''),
        Locale('ca', ''),
        Locale('es', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/login',
    );
  }
}
