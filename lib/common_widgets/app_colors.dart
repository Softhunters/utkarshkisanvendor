import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Colors.black;
  static const white = Colors.white;
  static const divideColor = Color(0xFFBFBEBE);
  static const transparentColor = Color(0xC9C9C8BE);
  static const grey = Color(0xFFE4E4E4);
  static const gery1Color = Color(0xFFE6E6E6);
  static const textFieldColor = Color(0xFFF6F6F6);
  static const ratingBGColor = Color(0xFFE7AF37);
  static const redColor = Color(0xFFE03804);
  static const greenColor = Color(0xFF16B71D);
  static const lightBlue = Color(0xFFedf5ff);
  static const couponBackground = Color(0xff6e9cd5);
  static  Color otpFieldColor = Color(0xFFBFBEBE);
  static const purple =Colors.purple;
  static const blue = Colors.blue;
  static const blueGrey = Colors.blueGrey;
  static const green = Colors.green;
  static const yellow =Colors.yellow;
  static const orange = Colors.orange;
  static const amber = Colors.amber;
  static const deepOrange = Colors.deepOrange;
  static const brown = Colors.brown;
  static const indigo = Colors.indigo;
  static const grey1 = Colors.grey;




  static const Color primaryBlack = Color(0xFF262834);
  static Color? primaryWhite = Colors.indigo[100];

  static List pieColors = [
    indigo[400],
    blue,
    green,
    amber,
    deepOrange,
    brown,
  ];
  static List<BoxShadow> neumorpShadow = [
    BoxShadow(
        color: white.withOpacity(0.1),
        spreadRadius: -5,
        offset: Offset(-5, -5),
        blurRadius: 30),
    BoxShadow(
        color: blue[900]!.withOpacity(.1),
        spreadRadius: 2,
        offset: Offset(7, 7),
        blurRadius: 20)
  ];

  static const splashGradient1Color = Colors.transparent;
  static Color splashGradient2Color = Colors.black.withOpacity(0.8);
}
