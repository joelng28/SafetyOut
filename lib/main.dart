import 'dart:async';
import 'package:app/app_localizations.dart';
import 'package:app/routes/router.dart';
import 'package:app/state/reg.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool loggedIn;
  await SecureStorage.readSecureStorage('SafetyOUT_Token').then(
      (value) => {if (value != null) loggedIn = true else loggedIn = false});
/*   await SecureStorage.readSecureStorage('userId').then(
      (value) => {if (value != null) loggedIn = true else loggedIn = false}); */
  runApp(ChangeNotifierProvider(
      create: (context) => RegState(),
      child: MyApp(
        initialRoute: loggedIn ? '/' : '/login',
      )));
}

class MyApp extends StatelessWidget {
  MyApp({this.initialRoute});
  final String initialRoute;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafetyOUT',
      themeMode: ThemeMode.system, //Uses default system theme
      // Més endevant podem controlar amb una variable si l'usuari ho canvia des de l'aplicació
      theme: ThemeData(
        dialogTheme:
            DialogTheme(contentTextStyle: TextStyle(color: Color(0xFF242424))),
        dialogBackgroundColor: Color(0xFFDBDBDB),
        primarySwatch: Colors.grey,
        primaryColor: Color(0xFFA7FF80),
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: Color(0xFFA7FF80)),
      ),
      darkTheme: ThemeData(
          primaryColorBrightness: Brightness.dark,
          dialogTheme: DialogTheme(
              contentTextStyle: TextStyle(color: Color(0xFFEAEAEA))),
          dialogBackgroundColor: Color(0xFF404040),
          primarySwatch: Colors.grey,
          primaryColor: Color(0xFFD2FFBE),
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: Color(0xFFD2FFBE)),
          scaffoldBackgroundColor: Color(0xFF242424),
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Color(0xFF242424)),
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Color(0xFF242424)),
          textTheme: TextTheme(bodyText2: TextStyle(color: Color(0xFFEAEAEA)))),

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
      initialRoute: this.initialRoute,
    );
  }
}
