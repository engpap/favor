import 'package:flutter/cupertino.dart';

bool textListEquals(List<dynamic>? a, List<dynamic>? b) {
  if (a == null) {
    return b == null;
  }
  if (b == null || a.length != b.length) {
    return false;
  }
  if (identical(a, b)) {
    return true;
  }
  for (int index = 0; index < a.length; index += 1) {
    if (a[index].toString() != b[index].toString()) {
      return false;
    }
  }
  return true;
}
