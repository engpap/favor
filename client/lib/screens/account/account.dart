import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/account/account_mobile.dart';
import 'package:project/screens/account/account_tablet.dart';
import 'package:project/screens/responsiveLayout.dart';

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
        child: CupertinoPageScaffold(
            backgroundColor: Colors.white,
            child: SafeArea(
              child: ResponsiveLeayout(
                mobileBody: AccountScreen_M(),
                tabletBody: AccountScreen_T(),
              ),
            )));
  }
}
