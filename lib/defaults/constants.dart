import 'package:flutter/material.dart';

// Singleton class that contains a bunch of useful constants for rapid and responsive developement
class Constants {
  //Constructor
  static final Constants _singleton = Constants._internal();

  //Font weights
  static final FontWeight lighter  = FontWeight.w200;
  static final FontWeight light    = FontWeight.w300;
  static final FontWeight normal   = FontWeight.normal;
  static final FontWeight bold     = FontWeight.bold;
  static final FontWeight bolder   = FontWeight.w800;

  //Colors used
  static final Color primary     = Color(0xFFA7FF80);
  static final Color primaryDark = Color(0xFF315C44);
  static final Color green       = Color(0xFFA7FF80);
  static final Color black       = Color(0xFF242424);
  static final Color darkGrey    = Color(0xFF404040);
  static final Color grey        = Color(0xFF8D8D8D);
  static final Color lightGrey   = Color(0xFFDBDBDB);
  static final Color white       = Color(0xFFEAEAEA);
  static final Color link        = Color(0xFF00FF9B);

  // Vertical spacings used for MARGINS and PADDINGS
  static double v1(BuildContext context) => 12 / (MediaQuery.of(context).size.height < 700 ? 1.6 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double v2(BuildContext context) => 14 / (MediaQuery.of(context).size.height < 700 ? 1.6 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double v3(BuildContext context) => 16 / (MediaQuery.of(context).size.height < 700 ? 1.6 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double v4(BuildContext context) => 18 / (MediaQuery.of(context).size.height < 700 ? 1.6 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double v5(BuildContext context) => 20 / (MediaQuery.of(context).size.height < 700 ? 1.6 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double v6(BuildContext context) => 24 / (MediaQuery.of(context).size.height < 700 ? 1.6 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double v7(BuildContext context) => 32 / (MediaQuery.of(context).size.height < 700 ? 1.6 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);

  // Font sizes
  static double xxs(BuildContext context) => 12 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double xs(BuildContext context) => 14 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double s(BuildContext context) => 16 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double m(BuildContext context) => 18 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double l(BuildContext context) => 20 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double xl(BuildContext context) => 24 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double xxl(BuildContext context) => 32 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);

  // Horizontal spacings used for MARGINS and PADDINGS
  static double h1(BuildContext context) => 12 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double h2(BuildContext context) => 14 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double h3(BuildContext context) => 16 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double h4(BuildContext context) => 18 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double h5(BuildContext context) => 20 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double h6(BuildContext context) => 24 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);
  static double h7(BuildContext context) => 32 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1);

  // Heights
  static double a1(BuildContext context) => 4 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a2(BuildContext context) => 8 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a3(BuildContext context) => 12 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a4(BuildContext context) => 16 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a5(BuildContext context) => 24 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a6(BuildContext context) => 32 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a7(BuildContext context) => 48 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a8(BuildContext context) => 64 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a9(BuildContext context) => 96 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a10(BuildContext context) => 128 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a11(BuildContext context) => 192 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a12(BuildContext context) => 256 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a13(BuildContext context) => 384 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double a14(BuildContext context) => 512 / (MediaQuery.of(context).size.height < 700 ? 1.3 : MediaQuery.of(context).size.height < 800 ? 1.15 : 1);
  static double aFull(BuildContext context) => double.infinity;

  // Widths
  static double w1(BuildContext context) => 4 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w2(BuildContext context) => 8 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w3(BuildContext context) => 12 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w4(BuildContext context) => 16 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w5(BuildContext context) => 24 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w6(BuildContext context) => 32 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w7(BuildContext context) => 48 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w8(BuildContext context) => 64 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w9(BuildContext context) => 96 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w10(BuildContext context) => 128 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w11(BuildContext context) => 192 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w12(BuildContext context) => 256 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w13(BuildContext context) => 384 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double w14(BuildContext context) => 512 / (MediaQuery.of(context).size.width < 380 ? 2 : 1);
  static double wFull(BuildContext context) => double.infinity;

  // Factory that creates the singleton
  factory Constants() {
    return _singleton;
  }
  //Neded for the singleton
  Constants._internal();
}