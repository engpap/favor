import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/stringExtensions.dart';
import 'package:project/models/profileConstants.dart';
import 'package:project/screens/components/customFieldMat.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/screens/signup2/signup2_mobile.dart';
import 'package:project/screens/signup2/signup2_tablet.dart';
import 'package:project/services/constantsService.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'globals.dart' as globals;

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
        //PAGE
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
/// Age, Gender, Residence, Job, Bio
class Form_SignUp2 extends StatefulWidget {
  const Form_SignUp2({super.key});

  @override
  State<Form_SignUp2> createState() => _Form_SignUp2State();
}

class _Form_SignUp2State extends State<Form_SignUp2> {
  final formKey_signup2 = GlobalKey<FormState>();

  late Future<ProfileConstants> profileConstants;
  @override
  void initState() {
    super.initState();
    profileConstants = ConstantsService().getProfileConstants();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
          color: Colors.transparent,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey_signup2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // AGE
                FutureBuilder<ProfileConstants>(
                    future: profileConstants,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomCard(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          child: CustomFieldMat(
                            prefixIcon: CupertinoIcons.profile_circled,
                            labelText: globals.LabelAge,
                            textEditingController: globals.ageContoller,
                            readOnly: true,
                            customValidator: (value) {
                              if (!value!.isValidAge()) {
                                return LabelSpace().whiteSpace() +
                                    "Insert a correct age.";
                              } else {
                                return null;
                              }
                            },
                            isSuffixClear: false,
                            isSuffixPicker: true,
                            contentList: snapshot.data!.ages,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CupertinoActivityIndicator(
                          animating: false, radius: 10);
                    })),
                SizedBox(
                  height: 10,
                ),
                // GENDER
                FutureBuilder<ProfileConstants>(
                    future: profileConstants,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomCard(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          child: CustomFieldMat(
                            prefixIcon: CupertinoIcons.profile_circled,
                            labelText: globals.LabelGender,
                            textEditingController: globals.genderContoller,
                            readOnly: true,
                            customValidator: (value) {
                              if (value == "")
                                return LabelSpace().whiteSpace() +
                                    "Select a gender from the picker.";
                              /**
                              if (!value!.isValidGender()) 
                                {return LabelSpace().whiteSpace()+"Just insert letter F or M";}
                              */
                              else {
                                return null;
                              }
                            },
                            isSuffixClear: false,
                            isSuffixPicker: true,
                            contentList: snapshot.data!.genders,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CupertinoActivityIndicator(
                          animating: false, radius: 10);
                    })),
                SizedBox(
                  height: 10,
                ),
                // RESIDENCE
                FutureBuilder<ProfileConstants>(
                    future: profileConstants,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomCard(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          child: CustomFieldMat(
                            prefixIcon: CupertinoIcons.profile_circled,
                            labelText: globals.LabelResidence,
                            textEditingController: globals.residenceContoller,
                            readOnly: true,
                            customValidator: (value) {
                              if (value == "")
                                return LabelSpace().whiteSpace() +
                                    "Select a city from the picker.";
                              /**
                              if (value!.length < 1 || !value.isValidResidence()) 
                                {return LabelSpace().whiteSpace()+"You can't insert special characters";}
                              if (value.length > 50) 
                                {return LabelSpace().whiteSpace()+"max 50 chars";}
                              */
                              else {
                                return null;
                              }
                            },
                            isSuffixClear: false,
                            isSuffixPicker: true,
                            contentList: snapshot.data!.cities,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CupertinoActivityIndicator(
                          animating: false, radius: 10);
                    })),
                SizedBox(
                  height: 10,
                ),
                // JOB
                FutureBuilder<ProfileConstants>(
                    future: profileConstants,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomCard(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          child: CustomFieldMat(
                            prefixIcon: CupertinoIcons.profile_circled,
                            labelText: globals.LabelJob,
                            textEditingController: globals.jobContoller,
                            readOnly: true,
                            customValidator: (value) {
                              if (value == "")
                                return LabelSpace().whiteSpace() +
                                    "Select your from the picker.";
                              /*
                              if (value!.length < 1 || !value.isValidJob()) 
                                {return LabelSpace().whiteSpace()+"You can't insert number or special characters";}
                              if (value.length > 50) 
                                {return LabelSpace().whiteSpace()+"max 50 chars";}
                              */
                              else {
                                return null;
                              }
                            },
                            isSuffixClear: false,
                            isSuffixPicker: true,
                            contentList: snapshot.data!.jobs,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CupertinoActivityIndicator(
                          animating: false, radius: 10);
                    })),
                SizedBox(
                  height: 10,
                ),
                // BIO
                CustomCard(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: CustomFieldMat(
                    prefixIcon: CupertinoIcons.profile_circled,
                    labelText: globals.LabelBio,
                    textEditingController: globals.bioContoller,
                    textInputAction: TextInputAction.done,
                    customValidator: (value) {
                      if (value!.length < 1 || !value.isValidJob()) {
                        return LabelSpace().whiteSpace() +
                            "Briefly describe yourself.";
                      }
                      if (value.length > 50) {
                        return LabelSpace().whiteSpace() + "max 50 chars";
                      } else {
                        return null;
                      }
                    },
                    isSuffixClear: true,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

/// BUTTON register.
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
            // Send information to server and wait for response
            globals.authService.insertPersonalInfo(
              context: context,
              age: globals.ageContoller.text,
              gender: globals.genderContoller.text,
              city: globals.residenceContoller.text,
              job: globals.jobContoller.text,
              bio: globals.bioContoller.text,
            );
          },
        ),
      ),
    );
  }
}
