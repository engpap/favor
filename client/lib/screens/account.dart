// TODO Account page
import 'package:flutter/cupertino.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/home.dart';
import 'package:project/services/authService.dart';
import 'package:provider/provider.dart';

import 'package:project/functions/tabs.dart' as FavorTab;

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  CupertinoTabController tabController = FavorTab.tabController;

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
          child: Column(
            children: [
              CupertinoButton(
                child: Text("cambio schermo 2"),
                  //child: Text("${Provider.of<UserProvider>(context, listen: false).user?.name}"),
                  //child: Text("${UserProvider().user?.name.toString()}"),
                onPressed: (() {
                  tabController.index = 2;
                  //print(tabController.index);
                }
                )),
                // LOG OUT
                CupertinoButton(
                  child: Text("Log Out"),
                  onPressed: (() {
                    AuthService().signout(context: context);
                  }
                )),
              FutureBuilder<String?>(
                  future: Storage.getUserToken(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text('Token got from server: ${snapshot.data!}');
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return CupertinoActivityIndicator(
                        animating: false, radius: 10);
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
