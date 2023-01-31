import 'dart:math';

import 'package:flutter/material.dart';

class Responsive {
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }

  static heightFixOver(double fixH, double overH, BuildContext context) {
    double minRequired = MediaQuery.of(context).size.height * (overH / 100);
    return minRequired > fixH ? fixH : minRequired;
  }

  static widthFixOver(double fixW, double overW, BuildContext context) {
    double minRequired = MediaQuery.of(context).size.width * (overW / 100);
    return minRequired > fixW ? fixW : minRequired;
  }

  static homeColumnWidth(BuildContext context) {
    double contextWidth = MediaQuery.of(context).size.width;
    double result;
    if (contextWidth <= 360) {
      result = contextWidth - 20;
    }
    else {
      result = (contextWidth / 3);
    }
    return min(370, result).toDouble();
  }
}
