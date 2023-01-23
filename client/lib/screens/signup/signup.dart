import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/errors/error.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/stringExtensions.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/components/customFieldMat.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/screens/components/customField.dart';

import 'package:project/screens/signin/signin.dart';
import 'package:project/screens/signup/signup_mobile.dart';
import 'package:project/screens/signup/signup_tablet.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'globals.dart' as globals;

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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

            //BCKGROUND GRADIENT IMAGE
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
                    mobileBody: SignUpScreen_M(),
                    tabletBody: SignUpScreen_T(),
                  ),
                ))));
  }
}


/// Name, Surname, Email, Password, PasswordConfirm
class Form_SignUp extends StatefulWidget {
  const Form_SignUp({super.key});

  @override
  State<Form_SignUp> createState() => _Form_SignUpState();
}

class _Form_SignUpState extends State<Form_SignUp> {
  final formKey_signup = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey_signup,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// NAME
              CustomCard(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: CustomFieldMat(
                  prefixIcon: CupertinoIcons.profile_circled,
                  labelText: globals.LabelName,
                  textEditingController: globals.textControllerName, 
                  customValidator: (value) {                             
                    if (value!.length < 1 || !value.isValidName()) 
                      {return LabelSpace().whiteSpace()+"You can't insert number or special characters";}
                    if (value.length > 50) 
                      {return LabelSpace().whiteSpace()+"max 50 chars";}   
                    else {return null;}
                  },
                  isSuffixClear: true,
                ),
              ),
              SizedBox(height: 10,),
              /// SURNAME
              CustomCard(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: CustomFieldMat(
                  prefixIcon: CupertinoIcons.profile_circled,
                  labelText: globals.LabelSurname,
                  textEditingController: globals.textControllerSurname,
                  customValidator: (value) {                             
                    if (value!.length < 1 || !value.isValidName()) 
                      {return LabelSpace().whiteSpace()+"You can't insert number or special characters";}
                    if (value.length > 50) 
                      {return LabelSpace().whiteSpace()+"max 50 chars";}   
                    else {return null;}
                  },
                  isSuffixClear: true,
                ),
              ),
              SizedBox(height: 10,),
              /// EMAIL
              CustomCard(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: CustomFieldMat(
                  prefixIcon: CupertinoIcons.mail_solid,
                  labelText: globals.LabelEmail,
                  textEditingController: globals.textControllerEmail,
                  textInputType: TextInputType.emailAddress,
                  customValidator: (value) {                             
                    if (value!.length < 1 || !value.isValidEmail()) 
                      {return LabelSpace().whiteSpace()+"You can't insert number or special characters";}
                    if (value.length > 50) 
                      {return LabelSpace().whiteSpace()+"max 50 chars";}   
                    else {return null;}
                  },
                  isSuffixClear: true,
                ),
              ),
              SizedBox(height: 10,),
              /// PASSWORD
              CustomCard(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: CustomFieldMat(
                  prefixIcon: CupertinoIcons.lock_circle_fill,
                  labelText: globals.LabelPassword,
                  textEditingController: globals.textControllerPassword,
                  obcureText: true,
                  customValidator: (value) {                             
                    if (value!.length < 1 || !value.isValidPassword()) 
                      {return LabelSpace().whiteSpace()+"at least 8 characters long and contains at least one uppercase letter, one lowercase letter, and one digit";}
                    if (value.length > 50) 
                      {return LabelSpace().whiteSpace()+"max 50 chars";}   
                    else {return null;}
                  },
                  isSuffixClear: true,
                ),
              ),
              SizedBox(height: 10,),
              /// PASSWORD2
              CustomCard(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: CustomFieldMat(
                  prefixIcon: CupertinoIcons.lock_circle_fill,
                  labelText: globals.LabelPasswordConfirm,
                  textEditingController: globals.textControllerPasswordConfirm,
                  textInputAction: TextInputAction.done,
                  obcureText: true,
                  customValidator: (value) {                             
                    if (value!.length < 1 || !value.isValidPassword()) 
                      {return LabelSpace().whiteSpace()+"at least 8 characters long and contains at least one uppercase letter, one lowercase letter, and one digit";}
                    if (value.length > 50) 
                      {return LabelSpace().whiteSpace()+"max 50 chars";}
                    if (value != globals.textControllerPassword.text) 
                      {return LabelSpace().whiteSpace()+"The two password must be equal";}
                    else {return null;}
                  },
                  isSuffixClear: true,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

/// BUTTON register.
/// checks information validity both client and server sides.
/// if all good push HomeScreen()
class SignUp_registerButton extends StatelessWidget {
  const SignUp_registerButton({super.key});

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
            print('Pressed: SignUp_registerButton');
            print('run: authService.signup');

            // Send information to server and wait for response
            globals.authService.signup(
              context: context,
              name: globals.textControllerName.text,
              surname: globals.textControllerSurname.text,
              email: globals.textControllerEmail.text,
              password: globals.textControllerPassword.text,
              confirmPassword: globals.textControllerPasswordConfirm.text,
            );
            /*Future<ErrorMessage> signupResponse = globals.authService
                .signup(
              name: globals.textControllerName.text,
              surname: globals.textControllerSurname.text,
              email: globals.textControllerEmail.text,
              password: globals.textControllerPassword.text,
              confirmPassword: globals.textControllerPasswordConfirm.text,
            )
                .then((value) {
              // Update fields status in base of client check and the server response output
              globals.UpdateFieldsStatus(value);
              // if fields are valid go to signin screen, else stay in this page
              if (globals.IsFieldsValid()) {
                print('IsFieldsValid = TRUE: push SingInScreen()');
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const SignInScreen()),
                );
              } else {
                print('IsFieldsValid = FALSE!');
              }
            });*/
          },
        ),
      ),
    );
  }
}

/// SIGNIN BUTTON
class SignUp_loginButton extends StatelessWidget {
  const SignUp_loginButton({super.key});

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
          color: favorColors.SecondaryBlue,
          child: const Text("Sign In",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          onPressed: () {
            print('Pressed: SignUp_loginButton');
            Navigator.pop(
              context,
              CupertinoPageRoute(builder: (context) => const SignInScreen()),
            );
          },
        ),
      ),
    );
  }
}
