import 'package:flutter/material.dart';

class Responsive {
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }

  static widthAuto(BuildContext context) {
    //TODO distinguere tra tablet e phone, if width > x pixel return bigWidth else smallWidth
  }

  // Use this function to set width of column (that refers to phone layouts) in tablet layouts
  static fixedWidth() {
    return 370.toDouble();
  }
}
