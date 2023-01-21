import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';

class customFieldMat extends StatelessWidget {
  customFieldMat({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.textEditingController,
    required this.customValidator,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.obcureText = false,
    //this.maxLength = 50,
    this.isSuffixClear = false,
    this.suffixButton = const CupertinoButton(
      onPressed: null,
      child: Text(""),
    ),
  });

  /// REQUIRED PARAMETERS
  final String labelText;
  IconData prefixIcon;
  TextEditingController textEditingController;
  String? Function(String?)? customValidator;

  /// OPTIONAL PARAMETER
  //pass <textInputAction: TextInputAction.done> for the last field
  final TextInputAction textInputAction;
  //pass <textInputType: TextInputType.emailAddress> for email field
  final TextInputType textInputType;
  //pass <obcureText: true> for password field
  final bool obcureText;
  //pass the maximum length of the field, default 50 characters
  //int maxLength;
  //do you want clearButton as suffixIcon? deafult false. 
  //This as priority on suffixButton
  bool isSuffixClear;
  //pass a custom <CupertinoButton()> as sufixIcon, deafult: null.
  //Remeber to keep isSuffixClear = false.
  CupertinoButton suffixButton;

  
  MaterialStateColor stateColor() =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.error)) {
          return favorColors.Error;
        }
        if (states.contains(MaterialState.focused)) {
          return favorColors.SecondaryBlue;
        }
        return Colors.black45;
      });

    MaterialStateColor stateColorIcon() =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.error)) {
          return favorColors.Error;
        }
        if (!states.contains(MaterialState.error)) {
          return favorColors.SecondaryBlue;
        }
        // if (states.contains(MaterialState.focused)) {
        //   return favorColors.SecondaryBlue;
        // }
        return Colors.black45;
      });

  MaterialStateTextStyle stateColorText() =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.error)) {
          return TextStyle(color: Colors.black45);
        }
        if (states.contains(MaterialState.focused)) {
          return TextStyle(color: favorColors.SecondaryBlue);
        }
        return TextStyle(color: Colors.black45);
      });

  ThemeData inputTheme() =>
    ThemeData(
      // TEXT ERROR
      errorColor: favorColors.Error,
      // INPUT FIELD
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: stateColorIcon(),
        labelStyle: stateColorText(),
        floatingLabelStyle: stateColorText(),
        // DEFAULT BORDER
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            //color: Colors.black12,
            style: BorderStyle.none,
          ),
          //borderRadius: BorderRadius.circular(45.0)
        ),
        // ENABLED BORDER
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            //color: Colors.black12,
            style: BorderStyle.none,
          ),
          //borderRadius: BorderRadius.circular(45.0)
        ),
        // FOCUSED BORDER
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            //color: favorColors.SecondaryBlue,
            style: BorderStyle.none,
          ),
          //borderRadius: BorderRadius.circular(20.0)
        ),
        // ERROR BORDER
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: favorColors.Error,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(45.0)
        ), 
        // FOCUSED ERROR BORDER
        focusedErrorBorder:UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black45,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(20.0)
        ),  
      ),
    );

  CupertinoButton clearButton() => 
    CupertinoButton(
      child: Icon(
        CupertinoIcons.xmark_circle_fill,
        color: favorColors.Yellow.withOpacity(0.8),
      ),
      onPressed: () => textEditingController.clear(),
    );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: inputTheme(),
        child: TextFormField(
          controller: textEditingController,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          obscureText: obcureText,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            labelText: labelText,
            suffixIcon: isSuffixClear 
              ? clearButton()
              : suffixButton,
            errorStyle: TextStyle(textBaseline: TextBaseline.ideographic)
          ),
          cursorColor: stateColor(),
          cursorRadius: Radius.circular(8),
          validator: customValidator,
          //maxLength: maxLength,
        ),
      ),
    );
  }
}
