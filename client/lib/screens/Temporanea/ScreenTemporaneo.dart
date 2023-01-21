import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/screens/Temporanea/customFieldMat.dart';

class ScreenTemporaneo extends StatelessWidget {
  const ScreenTemporaneo({super.key});
  
  final String wspace = "         ";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Container(
            color: Colors.amberAccent,
            child: Container(
              margin: EdgeInsets.all(18),
              color: Colors.white,
              /// CONTENUTO
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    customFieldMat(
                      labelText: 'Enter your username',
                      prefixIcon: CupertinoIcons.profile_circled,
                      textEditingController: TextEditingController(),
                      customValidator: (value) {
                        if (value!.length < 4) {return wspace+"troppo corta";}
                        else {return null;}
                      },
                    ),

                    SizedBox(height: 5,),

                    customFieldMat(
                      labelText: 'Enter your username',
                      prefixIcon: Icons.abc,
                      textEditingController: TextEditingController(),
                      customValidator: (value) {
                        if (value!.length > 4) {return wspace+"troppo lunga";}
                        else {return null;}
                      },
                      suffixButton:  CupertinoButton(
                        onPressed: () => {},
                        child: Text("Principe"),
                      ),

                    ),

                    SizedBox(height: 5,),
                  ],
                ),
              ),
              

            ),
          ),
        ),
      ),
    );
  }
}