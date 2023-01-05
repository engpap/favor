import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/errors/error.dart';
import 'package:project/errors/errorConstants.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/screens/components/customField.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/screens/signup2/signup2_mobile.dart';

import 'signup2_tablet.dart';


class SignUp2Screen extends StatelessWidget {
  const SignUp2Screen({super.key});

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
            //BACKGROUND GRADIENT IMAGE
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/bg_blue_gradient.jpg"),
              fit: BoxFit.cover,
              opacity: 1,
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.softLight,
              ),
            )),
            child: CupertinoPageScaffold(
                // .withAlpha(180) is used to add transparency, in order to see the bg-image
                backgroundColor: favorColors.IntroBg.withAlpha(180),
                child: SafeArea(
                  child: ResponsiveLeayout(
                    mobileBody: SignUp2Screen_M(),
                    tabletBody: SignUp2Screen_T(),
                  ),
                ))));
  }
}



const List<String> list = <String>['One', 'Two', 'Three', 'Four', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17'];

/// CALLER FORM
class Form_SignUp2 extends StatefulWidget {
  const Form_SignUp2({super.key});

  @override
  State<Form_SignUp2> createState() => _Form_SignUp2State();
}

class _Form_SignUp2State extends State<Form_SignUp2> {
  final formKey_signup2 = GlobalKey<FormState>();
  String dropdownValue = list.first;

  TextEditingController ageContoller = TextEditingController();
  TextEditingController genderContoller = TextEditingController();
  TextEditingController residenceContoller = TextEditingController();
  TextEditingController jobContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: Responsive.height(20, context),
      
      child: Material(
        color: Colors.transparent,
        child: Form(
          key: formKey_signup2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // AGE
              CustomField(
                prefixIcon: CupertinoIcons.profile_circled, 
                placeholder: "Enter your Age", 
                textController: ageContoller, 
                status: ErrorConstants.NO_ERROR
              ),
              // GENDER
              CustomField(
                prefixIcon: CupertinoIcons.profile_circled, 
                placeholder: "Enter your gender", 
                textController: genderContoller, 
                status: ErrorConstants.NO_ERROR
              ),
              // RESIDENCE
              CustomField(
                prefixIcon: CupertinoIcons.profile_circled, 
                placeholder: "Enter your residence", 
                textController: residenceContoller, 
                status: ErrorConstants.NO_ERROR
              ),
              // JOB
              CustomField(
                prefixIcon: CupertinoIcons.profile_circled, 
                placeholder: "Enter your job", 
                textController: jobContoller, 
                status: ErrorConstants.NO_ERROR
              ),


              /** 
              TextFormField(),
              DropdownButtonFormField(
                menuMaxHeight: Responsive.height(30, context),
                value: dropdownValue,
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(), 
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
              )
              */
            ],
          ),
        )
      ),
    );
  }
}


class customHeadigDesc extends StatelessWidget {
  customHeadigDesc({
    super.key,
    required this.heading,
    required this.description,
  });

  String heading;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// PAGE TITLE
          Container(
            width: Responsive.width(100, context), 
            margin: EdgeInsets.only(right: 9, left: 9),
            child: Text(heading,
              style: TextStyle(
                color: favorColors.PrimaryBlue,
                fontSize: 37,
                fontWeight: FontWeight.bold),
            ),
          ),
          /// DESCRIPTION
          Container(
            width: Responsive.width(100, context),
            margin: EdgeInsets.only(
              top: Responsive.height(1, context),
              bottom: Responsive.height(3, context),
              right: 9,
              left: 9),
            child: Text( description,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: favorColors.PrimaryBlue,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}


/// BUTTON register.
/// checks information validity both client and server sides.
/// if all good push HomeScreen()
class RegisterButton_SignUp2 extends StatelessWidget {
  const RegisterButton_SignUp2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 9, right: 9, left: 9, bottom: 9),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: SizedBox(
        width: Responsive.width(65, context),
        child: CupertinoButton(
          color: favorColors.PrimaryBlue,
          child: const Text(
            "Register",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            // Console log
            print('Pressed: RegisterButton_SignUp2');
            print('run: authService.signup');

            /**
             * TODO: RIFARE
            // Send information to server and wait for response
            globals.authService.signup(
              context: context,
              name: globals.textControllerName.text,
              surname: globals.textControllerSurname.text,
              email: globals.textControllerEmail.text,
              password: globals.textControllerPassword.text,
              confirmPassword: globals.textControllerPasswordConfirm.text,
            );
            */
          },
        ),
      ),
    );
  }
}
