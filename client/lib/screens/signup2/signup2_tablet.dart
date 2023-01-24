import 'package:flutter/cupertino.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/components/customHeadingDesc.dart';
import 'package:project/screens/signup2/signup2.dart';

class SignUp2Screen_T extends StatelessWidget {
  const SignUp2Screen_T({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [  
                /// TWO BLOCKS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1st BLOCK
                    SingleChildScrollView(
                      reverse: true,
                      child: Container(
                        width: Responsive.fixedWidth(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // HEADING + DESCRIPTION
                            customHeadingDesc(
                              heading: "Create Account", 
                              description: "These information will be used for our research."
                            ),
                            // BUTTON
                            RegisterButton_SignUp2(),
                          ],
                        ),
                      ),
                    ),
                    // 2nd BLOCK
                    SingleChildScrollView(
                      reverse: true,
                      child: Container(
                        width: Responsive.fixedWidth(),
                        // FORM
                        child: Form_SignUp2(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }
}