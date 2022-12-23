// TODO Account page
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/tabs.dart';
import 'package:project/providers/getters.dart';
import 'package:project/providers/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../errors/errorConstants.dart';
import 'components/customField.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        child: SafeArea(
            child: Center(
          child: FutureBuilder<String?>(
              future: Storage.getUserToken(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Token got from server: ${snapshot.data!}');
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return CupertinoActivityIndicator(animating: false, radius: 10);
              }),
        )),
      ),
    );
  }
}
