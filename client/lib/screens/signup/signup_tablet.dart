import 'package:flutter/material.dart';
import 'package:project/screens/signup/signup.dart';
import 'package:project/functions/responsive.dart';

class SignUpScreen_T extends StatefulWidget {
  const SignUpScreen_T({super.key});

  @override
  State<SignUpScreen_T> createState() => _SignUpScreen_TState();
}

class _SignUpScreen_TState extends State<SignUpScreen_T> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
        const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Center(
        
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                //flex: 2,
                /// PAGE TITLE
                child: Container(
                  height: Responsive.height(80, context),
                  decoration: BoxDecoration(
                    //TODO: change this background
                    color: Color.fromARGB(135, 116, 29, 223),
                    backgroundBlendMode: BlendMode.color
                  ),
                  child: Center(
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                        fontWeight: FontWeight.bold),
                    ),
                  ),),),
              SingleChildScrollView(
                reverse: true,
                child: Container(
                  //TODO: use a global variable, not 370 
                  width: 370,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SignUp_form(),
                      Divider(height: Responsive.height(5, context),),
                      SignUp_registerButton(),
                      Divider(height: Responsive.height(5, context)),
                      Text(
                        "Have an account?",
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 16),
                      ),
                      SignUp_loginButton(),
                    ]),
                ),
              ),
            ],
          ),

      ),
    );
  }
}