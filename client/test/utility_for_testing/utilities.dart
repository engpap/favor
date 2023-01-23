import 'package:flutter/cupertino.dart';

Widget getApp(Widget widget) => CupertinoApp(
      home: Builder(
        builder: (context) {
          return widget;
        },
      ),
    );
