import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/home.dart';

class Favor2_Screen_M extends StatefulWidget {
  const Favor2_Screen_M({super.key});

  @override
  State<Favor2_Screen_M> createState() => _Favor2_Screen_MState();
}

class _Favor2_Screen_MState extends State<Favor2_Screen_M> {
  //UserMode_inherited.of(context).stateWidget.getUserMode()

  @override
  Widget build(BuildContext context) {
    if (UserMode_inherited.of(context).stateWidget.isUserModeAs_caller()){
      // CALLER
      return Material(
        child: Container(
          child: FavorForm_caller(),
        ),
      );
    } else if (UserMode_inherited.of(context).stateWidget.isUserModeAs_provider()){
      // PROVIDER
      return Container(
        child: Text("Provider"),
      );
    } else {
      // UserMode not on Caller nor Provider
      return Container(
        child: Text("Your are not allowed to create a new favor"),
      );
    }

  }
}




const List<String> list = <String>['One', 'Two', 'Three', 'Four', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17'];

/// CALLER FORM
class FavorForm_caller extends StatefulWidget {
  const FavorForm_caller({super.key});

  @override
  State<FavorForm_caller> createState() => _FavorForm_callerState();
}

class _FavorForm_callerState extends State<FavorForm_caller> {
  final formKey_caller = GlobalKey<FormState>();

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      color: Colors.amber,
      child: Material(
        child: Form(
          key: formKey_caller,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(),
              DropdownButtonFormField(
                menuMaxHeight: Responsive.height(20, context),
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
              
            ],
          ),
        )
      ),
    );
  }
}


/// PROVIDER FORM







/** 

/// PICKER MENU
class Favor_pickerMenu extends StatefulWidget {
  // List of item showed in the menu'
  final List<Text> contentList;
  // menu placeholder
  final String placeholder;
  // menu description
  final String heading;
  //pass <CupertinoIcons.something> for the prefix
  final IconData prefixIcon;
  // to manipulate the content of the texfield
  TextEditingController textController;
  // !! funziana solo con le flag 1-2-3-4-5 per il form menu dei nuovi favor. Non riutilizzare questo widget a caso
  int flag = 0;

  Favor_pickerMenu(
      {super.key,
      required this.placeholder,
      required this.heading,
      required this.contentList,
      required this.prefixIcon,
      required this.textController,
      required this.flag});

  @override
  State<Favor_pickerMenu> createState() => _Favor_pickerMenuState();
}

class _Favor_pickerMenuState extends State<Favor_pickerMenu> {
  // initial value displayed 0
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            //DESCRIPTION
            SizedBox(
              width: Responsive.width(100, context),
              child: Text(
                "${widget.heading}",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(
              height: Responsive.height(1, context),
              color: Colors.transparent,
            ),
            // TEXTFIELD
            CupertinoTextField(
              prefix: CupertinoButton(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                child: Icon(
                  widget.prefixIcon,
                ),
                onPressed: null,
              ),
              placeholder: widget.placeholder,
              controller: widget.textController,
              // PICKER BUTTON
              suffix: CupertinoButton(
                child: Icon(
                  CupertinoIcons.arrowtriangle_down_circle,
                  color: favorColors.SecondaryBlue,
                ),
                onPressed: (() => showCupertinoModalPopup(
                    context: context,
                    builder: (_) => SizedBox(
                          width: Responsive.width(100, context),
                          height: Responsive.height(20, context),
                          child: CupertinoPicker(
                            backgroundColor: Colors.white,
                            itemExtent: Responsive.height(5, context), //height of current item
                            scrollController: FixedExtentScrollController(
                              initialItem: selectedValue,
                            ),
                            children: widget.contentList,
                            onSelectedItemChanged: (int value) {
                              if (this.mounted) {
                              setState(() {
                                selectedValue = value;
                                // TODO: if possible remove these flags and use a cleaner approach
                                if (widget.flag == 1) {
                                  globals.categoryTextController =
                                      TextEditingController(
                                          text:
                                              '${widget.contentList.elementAt(selectedValue).data}');
                                }
                                if (widget.flag == 2) {
                                  globals.locationTextController =
                                      TextEditingController(
                                          text:
                                              '${widget.contentList.elementAt(selectedValue).data}');
                                }
                                if (widget.flag == 3) {
                                  globals.availabilityStartTimeTextController =
                                      TextEditingController(
                                          text:
                                              '${widget.contentList.elementAt(selectedValue).data}');
                                }
                                if (widget.flag == 4) {
                                  globals.availabilityEndTimeTextController =
                                      TextEditingController(
                                          text:
                                              '${widget.contentList.elementAt(selectedValue).data}');
                                }
                                if (widget.flag == 5) {
                                  globals.favorStartTimeTextController =
                                      TextEditingController(
                                          text:
                                              '${widget.contentList.elementAt(selectedValue).data}');
                                }
                              });
                              }

                            },
                          ),
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/