import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../errors/errorConstants.dart';

class CustomField extends StatefulWidget {
  /// REQUIRED PARAMETERS
  //pass <CupertinoIcons.something> for the prefix
  final IconData prefixIcon;
  final String placeholder;
  final TextEditingController textController;
  final String status;

  /// OPTIONAL PARAMETER
  //pass <textInputAction: TextInputAction.done> for the last field
  final TextInputAction textInputAction;
  //pass <textInputType: TextInputType.emailAddress> for email field
  final TextInputType textInputType;
  //pass <obcureText: true> for password field
  final bool obcureText;

  const CustomField({
    super.key,
    required this.prefixIcon,
    required this.placeholder,
    required this.textController,
    required this.status,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.obcureText = false,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {

  Color mainColor = Colors.black45;
  //Color mainColor = Colors.amber;
  //Color secondColor = Colors.white;

  // Can return error color, valid color or default/base one
  Color colorStatus(Color base) {
    if(widget.status != ErrorConstants.NO_ERROR 
      && widget.status != ErrorConstants.UNCHECKED_ERROR)
      return Colors.redAccent;
    else if (widget.status == ErrorConstants.NO_ERROR)
      return Colors.blueAccent;
    else return base;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 9, right: 9),
          child: CupertinoTextField(
            textInputAction: widget.textInputAction, //widget
            keyboardType: widget.textInputType, //widget
            padding: EdgeInsets.only(top: 9, bottom: 9),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              //backgroundColor: colorStatus(Colors.white).withOpacity(0.1),
              /* shadows: [Shadow(
                color: colorStatus(Colors.white),
                offset: Offset(0, 0),
                blurRadius: 30.0,
                )] */
              ),
            decoration: BoxDecoration(   
              color: Colors.white,
              border: Border.all(color: colorStatus(Colors.white),),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            cursorColor: colorStatus(mainColor),
            cursorWidth: 3,
            cursorRadius: Radius.circular(10),
            // prefix button
            prefix: CupertinoButton(
              padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
              child: Icon(
                widget.prefixIcon, //widget
                color: colorStatus(mainColor),
              ),
              onPressed: null,
            ),
            // clear button
            suffix: CupertinoButton(
              padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
              child: Icon(
                CupertinoIcons.xmark_circle_fill,
                color: Colors.red.withOpacity(0.8),
              ),
              onPressed: () => widget.textController.clear(), //widget
            ),
            obscureText: widget.obcureText,
            maxLength: 30, // reasonable value
            maxLines: 1, // reasonable value
            placeholder: widget.placeholder,
            controller: widget.textController,
            onSubmitted: (value) =>
                print('Submitted [${widget.textController}]: $value'),
          ),
        ),
        (widget.status == "error") 
        ? Container(
          margin: EdgeInsets.only(left: 38, right: 9, top: 0),
          padding: EdgeInsets.only(left: 18, right: 18),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(   
              color: colorStatus(Colors.white).withOpacity(0.9),
              //border: Border.all(color: colorStatus(Colors.white),),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          child: Text("${widget.status}",
            style: TextStyle(color: Colors.black87,),
          ),
        ) 
        : Container(
          margin: EdgeInsets.only(left: 38, right: 9),
          padding: EdgeInsets.only(left: 18, right: 18),
          alignment: Alignment.centerLeft,
          child: Text("${widget.status}",
            style: TextStyle(color: Colors.transparent,),
          ),
        ),
      ],
    );
  }
}
