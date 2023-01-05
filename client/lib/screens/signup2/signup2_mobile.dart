import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/signup/signup.dart';
import 'package:project/screens/signup2/signup2.dart';

import 'package:project/functions/favorColors.dart' as favorColors;

class SignUp2Screen_M extends StatelessWidget {
  const SignUp2Screen_M({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: SingleChildScrollView(
        reverse: true,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.fixedWidth(),
          ),
          child: Column(
            children: [
              // HEADING +  DESCRIPTION
              customHeadigDesc(
                heading: "Create Account", 
                description: "Please fill all informations below."
              ),
              // FORM
              Form_SignUp2(),
              // BUTTON
              Divider(height: Responsive.height(2, context), color: Colors.transparent,),
              RegisterButton_SignUp2(),
            ],
          ),
        ),
      )
    );
  }
}