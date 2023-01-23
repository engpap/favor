import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';

class customFieldMat extends StatefulWidget {
  customFieldMat({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.textEditingController,
    required this.customValidator,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.obcureText = false,
    this.readOnly = false,
    //this.maxLength = 50,
    this.isSuffixClear = false,
    this.isSuffixPicker = false,
    this.contentList = const [Text("")],
    this.suffixButton = const CupertinoButton(
      onPressed: null,
      child: Text(""),
    ),
  });

  /// REQUIRED PARAMETERS
  final String labelText;
  IconData prefixIcon;
  TextEditingController textEditingController;
  String? Function(String?)? customValidator;

  /// OPTIONAL PARAMETER
  //pass <textInputAction: TextInputAction.done> for the last field
  final TextInputAction textInputAction;
  //pass <textInputType: TextInputType.emailAddress> for email field
  final TextInputType textInputType;
  //pass <obcureText: true> for password field
  final bool obcureText;
  //pass true to don't allow writes
  final bool readOnly;
  //pass the maximum length of the field, default 50 characters
  //int maxLength;

  //do you want clearButton as suffixIcon? deafult false.
  //This as priority on suffixButton and isSuffixPicker
  bool isSuffixClear;

  //do you want pickerButton as suffixIcon? deault false
  bool isSuffixPicker;
  // List of item showed in the picker menu'
  List<Text> contentList;

  //pass a custom <CupertinoButton()> as sufixIcon, deafult: null.
  //Remember to keep isSuffixClear = false.
  CupertinoButton suffixButton;

  @override
  State<customFieldMat> createState() => _customFieldMatState();
}

class _customFieldMatState extends State<customFieldMat> {
  // *** START PICKER ***
  int selectedValue = 0; // initial value 0
  late FixedExtentScrollController scrollController;
  // *** END PICKER ***

  MaterialStateColor stateColor() =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.error)) {
          return favorColors.Error;
        }
        if (states.contains(MaterialState.focused)) {
          return favorColors.SecondaryBlue;
        }
        return Colors.black45;
      });

  MaterialStateColor stateColorIcon() =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.error)) {
          return favorColors.Error;
        }
        if (!states.contains(MaterialState.error)) {
          return favorColors.SecondaryBlue;
        }
        // if (states.contains(MaterialState.focused)) {
        //   return favorColors.SecondaryBlue;
        // }
        return Colors.black45;
      });

  MaterialStateTextStyle stateColorText() =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.error)) {
          return TextStyle(color: Colors.black45);
        }
        if (states.contains(MaterialState.focused)) {
          return TextStyle(color: favorColors.SecondaryBlue);
        }
        return TextStyle(color: Colors.black45);
      });

  ThemeData inputTheme() => ThemeData(
        // TEXT ERROR
        errorColor: favorColors.Error,
        // INPUT FIELD
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: stateColorIcon(),
          labelStyle: stateColorText(),
          floatingLabelStyle: stateColorText(),
          // DEFAULT BORDER
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              //color: Colors.black12,
              style: BorderStyle.none,
            ),
            //borderRadius: BorderRadius.circular(45.0)
          ),
          // ENABLED BORDER
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              //color: Colors.black12,
              style: BorderStyle.none,
            ),
            //borderRadius: BorderRadius.circular(45.0)
          ),
          // FOCUSED BORDER
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              //color: favorColors.SecondaryBlue,
              style: BorderStyle.none,
            ),
            //borderRadius: BorderRadius.circular(20.0)
          ),
          // ERROR BORDER
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: favorColors.Error,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(45.0)),
          // FOCUSED ERROR BORDER
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black45,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(20.0)),
        ),
      );

  CupertinoButton clearButton() => CupertinoButton(
        child: Icon(
          CupertinoIcons.xmark_circle_fill,
          color: favorColors.Yellow.withOpacity(0.8),
        ),
        onPressed: () => widget.textEditingController.clear(),
      );

  // *** START PICKER ***
  // IF isSuffixPicker = TRUE
  // AND isSuffixClear = FALSE
  // picker Button will be used.

  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(
      initialItem: selectedValue,
    );
  }

  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  CupertinoButton pickerButton() => CupertinoButton(
      child: Icon(
        CupertinoIcons.arrowtriangle_down_circle_fill,
        color: favorColors.Yellow,
      ),
      onPressed: () {
        scrollController.dispose();
        scrollController =
            FixedExtentScrollController(initialItem: selectedValue);
        showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
                  actions: [buildPicker()],
                  cancelButton: CupertinoActionSheetAction(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ));
      });

  Widget buildPicker() => SizedBox(
        height: Responsive.height(30, context),
        child: StatefulBuilder(
          builder: (context, setState) => CupertinoPicker(
            backgroundColor: Colors.white,
            /*
        selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
          background: favorColors.SecondaryBlue.withOpacity(0.2),
        ),
        */
            itemExtent:
                32, //Responsive.height(5, context), //height of current item
            scrollController: scrollController,
            children: List.generate(widget.contentList.length, (index) {
              //final isSelected = this.selectedValue == index;
              //final color = isSelected ? favorColors.PrimaryBlue : Colors.black;
              final item = widget.contentList[index];
              return Center(
                  child: Text(
                item.data.toString(),
                style: TextStyle(
                  fontSize: 24, //color: color
                ),
              ));
            }),

            onSelectedItemChanged: (int value) {
              widget.textEditingController.text =
                  widget.contentList.elementAt(value).data.toString();
              if (this.mounted) {
                setState(() {
                  selectedValue = value;
                  print("Selected Value: ${selectedValue}");
                });
              }
            },
          ),
        ),
      );
  // *** END PICKER ***

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: inputTheme(),
        child: TextFormField(
          readOnly: widget.readOnly,
          controller: widget.textEditingController,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          obscureText: widget.obcureText,
          decoration: InputDecoration(
              prefixIcon: Icon(widget.prefixIcon),
              labelText: widget.labelText,
              suffixIcon: widget.isSuffixClear
                  ? clearButton()
                  : (widget.isSuffixPicker
                      ? pickerButton()
                      : widget.suffixButton),
              errorStyle: TextStyle(textBaseline: TextBaseline.ideographic)),
          cursorColor: stateColor(),
          cursorRadius: Radius.circular(8),
          validator: widget.customValidator,
          //maxLength: maxLength,
        ),
      ),
    );
  }
}
