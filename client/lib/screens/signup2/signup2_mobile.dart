import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/components/customHeadingDesc.dart';
import 'package:project/screens/signup2/signup2.dart';

class SignUp2Screen_M extends StatelessWidget {
  const SignUp2Screen_M({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Center(
        child: SingleChildScrollView(
          reverse: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width-20, //Responsive.homeColumnWidth(context), //Responsive.fixedWidth(),
            ),
            child: Column(
              children: [
                // HEADING +  DESCRIPTION
                customHeadingDesc(
                  heading: "Create Account", 
                  description: "These information will be used for our research."
                ),
                // FORM
                Form_SignUp2(),
                // BUTTON
                Divider(height: Responsive.height(2, context), color: Colors.transparent,),
                RegisterButton_SignUp2(),
              ],
            ),
          ),
        ),
      )
    );
  }
}