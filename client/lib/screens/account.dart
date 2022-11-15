// TODO Account page
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/tabs.dart';
import 'package:project/providers/getters.dart';

import '../errors/errorConstants.dart';
import 'components/customField.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final String _PlaceholderName = "Name";
  final String _PlaceholderSurname = "Surname";

  final TextEditingController _textControllerName =
      TextEditingController(text: "");
  final TextEditingController _textControllerSurname =
    TextEditingController(text: "");

  String _StatusName = ErrorConstants.UNCHECKED_ERROR;
  String _StatusSurname = ErrorConstants.UNCHECKED_ERROR;

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Divider(height: 20, color: Colors.transparent,),
              /// NAME
              Text("name", style: TextStyle(fontWeight: FontWeight.bold),),
              CustomField(
                prefixIcon: CupertinoIcons.profile_circled,
                placeholder: _PlaceholderName,
                textController: _textControllerName,
                status: _StatusName,
              ),
              Divider(height:5, color: Colors.transparent,),
              /// SURNAME
              Text("Surname", style: TextStyle(fontWeight: FontWeight.bold),),
              CustomField(
                prefixIcon: CupertinoIcons.profile_circled,
                placeholder: _PlaceholderSurname,
                textController: _textControllerSurname,
                status: _StatusSurname,
                textInputAction: TextInputAction.done,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
