import 'package:flutter/cupertino.dart';
import 'package:project/models/user.dart';
import 'package:provider/provider.dart';
import 'package:project/providers/userProvider.dart';

User getUserFromlocalStorage(BuildContext context) =>
    Provider.of<UserProvider>(context).user;
