import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/errors/error.dart';
import 'package:project/errors/errorConstants.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/stringExtensions.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/screens/components/customFieldMat.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/screens/components/customField.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/screens/signup2/signup2_mobile.dart';
import 'package:project/services/constantsService.dart';

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


/// SIGNUP2 FORM
class Form_SignUp2 extends StatefulWidget {
  const Form_SignUp2({super.key});

  @override
  State<Form_SignUp2> createState() => _Form_SignUp2State();
}

class _Form_SignUp2State extends State<Form_SignUp2> {
  final formKey_signup2 = GlobalKey<FormState>();

  final String wspace = "         ";

  TextEditingController ageContoller = TextEditingController();
  TextEditingController genderContoller = TextEditingController();
  TextEditingController residenceContoller = TextEditingController();
  TextEditingController jobContoller = TextEditingController();

  late Future<FavorConstants> favorConstants;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favorConstants = ConstantsService().getFavorConstants();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey_signup2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // AGE
              FutureBuilder<FavorConstants>(
                  future: favorConstants,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return CustomCard(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: customFieldMat(
                          prefixIcon: CupertinoIcons.profile_circled, 
                          labelText: "Your Age", 
                          textEditingController: ageContoller, 
                          customValidator: (value) {
                            if (!value!.isValidAge()) 
                              {return wspace+"Insert a correct age [min 0 - max 99]";}
                            else {return null;}
                          },
                          isSuffixClear: false,
                          isSuffixPicker: true,
                          contentList: snapshot.data!.favorCategories, //TODO: mettere lista corretta
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return CupertinoActivityIndicator(
                        animating: false, radius: 10);
              })),
              SizedBox(height: 10,),
              // GENDER
              FutureBuilder<FavorConstants>(
                  future: favorConstants,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return CustomCard(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: customFieldMat(
                          prefixIcon: CupertinoIcons.profile_circled, 
                          labelText: "Your gender", //  F (female) or M (male)
                          textEditingController: genderContoller, 
                          customValidator: (value) {
                            if (!value!.isValidGender()) 
                              {return wspace+"Just insert letter F or M";}
                            else {return null;}
                          },
                          isSuffixClear: false,
                          isSuffixPicker: true,
                          contentList: snapshot.data!.favorCategories, //TODO: mettere lista corretta
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return CupertinoActivityIndicator(
                        animating: false, radius: 10);
              })),
              SizedBox(height: 10,),
              // RESIDENCE
              FutureBuilder<FavorConstants>(
                  future: favorConstants,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return CustomCard(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: customFieldMat(
                          prefixIcon: CupertinoIcons.profile_circled, 
                          labelText: "Your residence", 
                          textEditingController: residenceContoller, 
                          customValidator: (value) {
                            if (value!.length < 1 || !value.isValidResidence()) 
                              {return wspace+"You can't insert special characters";}
                            if (value.length > 50) 
                              {return wspace+"max 50 chars";}
                            else {return null;}
                          },
                          isSuffixClear: false,
                          isSuffixPicker: true,
                          contentList: snapshot.data!.favorCategories, //TODO: mettere lista corretta
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return CupertinoActivityIndicator(
                        animating: false, radius: 10);
              })),
              SizedBox(height: 10,),
              // JOB
              FutureBuilder<FavorConstants>(
                  future: favorConstants,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return CustomCard(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: customFieldMat(
                          prefixIcon: CupertinoIcons.profile_circled, 
                          labelText: "Your job", 
                          textEditingController: jobContoller,
                          textInputAction: TextInputAction.done,
                          customValidator: (value) {
                            if (value!.length < 1 || !value.isValidJob()) 
                              {return wspace+"You can't insert number or special characters";}
                            if (value.length > 50) 
                              {return wspace+"max 50 chars";}
                            else {return null;}
                          },
                          isSuffixClear: false,
                          isSuffixPicker: true,
                          contentList: snapshot.data!.favorCategories, //TODO: mettere lista corretta
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return CupertinoActivityIndicator(
                        animating: false, radius: 10);
              })),

            ],
          ),
        )
      ),
    );
  }
}

class customHeadingDesc extends StatelessWidget {
  customHeadingDesc({
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
          child: Text(
            heading,
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
          child: Text(
            description,
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

            /**
            TODO: Collagare col server
            //print('run: authService.signup');
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

