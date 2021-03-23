import 'dart:async';

import 'package:app/app_localizations.dart';
import 'package:app/routes/router.dart';
import 'package:app/state/reg.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
/* import 'package:flutter_secure_storage/flutter_secure_storage.dart'; */
/* import 'package:mongo_dart/mongo_dart.dart'; */

/* Db db = Db('mongodb://localhost/test');
DbCollection coll = db.collection('people'); */

/*main(List<String> arguments) async {
  Db db = Db('mongodb://localhost:27017/test');
  await db.open();
  print('Connected to database');

  DbCollection coll = db.collection('people');
  //var people = await coll.find(where.eq('Email', 'Daniel'));
  var psswd1 = await coll.findOne(
      where.eq("Email", 'daniel.roru@otmail.com').fields(['Password']));
  String spsswd1 = psswd1.toString();
  print(spsswd1);
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 /*  await db.open(); */
  print('Connected to database');

/*   await coll.insertAll([
    {
      'First_name': 'Dani',
      'Last_name': 'Rodri',
      'Email': 'prova@hotmail.com',
      'Gender': 'Male',
      'Password': 'prova'
    }
  ]); */

  bool loggedIn;
  await SecureStorage.readSecureStorage('token').then(
      (value) => {if (value != null) loggedIn = true else loggedIn = false});
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
        primarySwatch: Colors.grey,
        primaryColor: Color(0xFFA7FF80),
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: Color(0xFFA7FF80)),
      ),
      darkTheme: ThemeData(
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
