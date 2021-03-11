import 'package:flutter/material.dart';

// Singleton class that contains a bunch of useful constants for rapid and responsive developement
class Constants {
  //Constructor
  static final Constants _singleton = Constants._internal();

  //Font weights
  final FontWeight lighter  = FontWeight.w200;
  final FontWeight light    = FontWeight.w300;
  final FontWeight normal   = FontWeight.normal;
  final FontWeight bold     = FontWeight.bold;
  final FontWeight bolder   = FontWeight.w800;

  //Colors used
  final Color primary     = Color(0xFFA7FF80);
  final Color primaryDark = Color(0xFF315C44);
  final Color green       = Color(0xFF1DB954);
  final Color black       = Color(0xFF121212);
  final Color darkGrey    = Color(0xFF212121);
  final Color grey        = Color(0xFF535353);
  final Color lightGrey   = Color(0xFFb3b3b3);
  final Color white       = Color(0xFFEAEAEA);

  // Vertical spacings used for MARGINS and PADDINGS
  double v1(BuildContext context) => 12 / (MediaQuery.of(context).size.height < 700 ? 2 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double v2(BuildContext context) => 14 / (MediaQuery.of(context).size.height < 700 ? 2 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double v3(BuildContext context) => 16 / (MediaQuery.of(context).size.height < 700 ? 2 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double v4(BuildContext context) => 18 / (MediaQuery.of(context).size.height < 700 ? 2 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double v5(BuildContext context) => 20 / (MediaQuery.of(context).size.height < 700 ? 2 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double v6(BuildContext context) => 24 / (MediaQuery.of(context).size.height < 700 ? 2 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double v7(BuildContext context) => 32 / (MediaQuery.of(context).size.height < 700 ? 2 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);

  // Font sizes
  double xxs(BuildContext context) => 12 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  double xs(BuildContext context) => 14 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  double s(BuildContext context) => 16 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  double m(BuildContext context) => 18 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  double l(BuildContext context) => 20 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  double xl(BuildContext context) => 24 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  double xxl(BuildContext context) => 32 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);

  // Horizontal spacings used for MARGINS and PADDINGS
  double h1(BuildContext context) => 12 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double h2(BuildContext context) => 14 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double h3(BuildContext context) => 16 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double h4(BuildContext context) => 18 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double h5(BuildContext context) => 20 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double h6(BuildContext context) => 24 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double h7(BuildContext context) => 32 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);

  // Heights
  double a1(BuildContext context) => 4 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a2(BuildContext context) => 8 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a3(BuildContext context) => 12 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a4(BuildContext context) => 16 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a5(BuildContext context) => 24 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a6(BuildContext context) => 32 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a7(BuildContext context) => 48 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a8(BuildContext context) => 64 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a9(BuildContext context) => 96 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a10(BuildContext context) => 128 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a11(BuildContext context) => 192 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a12(BuildContext context) => 256 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a13(BuildContext context) => 384 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double a14(BuildContext context) => 512 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  double aFull(BuildContext context) => double.infinity;

  // Widths
  double w1(BuildContext context) => 4 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w2(BuildContext context) => 8 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w3(BuildContext context) => 12 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w4(BuildContext context) => 16 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w5(BuildContext context) => 24 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w6(BuildContext context) => 32 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w7(BuildContext context) => 48 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w8(BuildContext context) => 64 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w9(BuildContext context) => 96 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w10(BuildContext context) => 128 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w11(BuildContext context) => 192 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w12(BuildContext context) => 256 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w13(BuildContext context) => 384 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double w14(BuildContext context) => 512 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  double wFull(BuildContext context) => double.infinity;

  // Factory that creates the singleton
  factory Constants() {
    return _singleton;
  }
  //Neded for the singleton
  Constants._internal();
}