import 'dart:async';

import 'package:app/defaults/constants.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //Aquí es comprovaria la clau d'accés
    Timer(Duration(seconds: 3), () {
      SecureStorage.readSecureStorage('token').then((value) => {
        if (value != null) Navigator.of(context).pushReplacementNamed('/')
        else Navigator.of(context).pushReplacementNamed('/login')
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Constants.aFull(context),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF84FCCD), Color(0xFFA7FF80)],
              begin: FractionalOffset.centerLeft,
              end: FractionalOffset.centerRight,
            )
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/logo.svg',
              color: Constants.white(context),
              height: 300 / (MediaQuery.of(context).size.height < 700 ? 1.5 : MediaQuery.of(context).size.height < 800 ? 1.3 : 1)
            ),
          ),
        ),
      )
    );
  }
}