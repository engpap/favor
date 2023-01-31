import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

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


  Favor_pickerMenu(
      {super.key,
      required this.placeholder,
      this.heading = "",
      required this.contentList,
      required this.prefixIcon,
      required this.textController,
      });

  @override
  State<Favor_pickerMenu> createState() => _Favor_pickerMenuState();
}

class _Favor_pickerMenuState extends State<Favor_pickerMenu> {
  int selectedValue = 0; // initial value 0
  late FixedExtentScrollController scrollController;
  //late TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            // DESCRIPTION
            (widget.heading == "") ? Container() : SizedBox(
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
                  color: favorColors.PrimaryBlue,
                ),
                onPressed: null,
              ),
              placeholder: widget.placeholder,
              controller: widget.textController,
              readOnly: true, //
              enableInteractiveSelection: false, //
              // BUTTON SHOW PICKER
              suffix: CupertinoButton(
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
                  }),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget buildPicker() => SizedBox(
        height: Responsive.height(30, context),
        child: StatefulBuilder(
          builder: (context, setState) => CupertinoPicker(
            backgroundColor: Colors.white,
            itemExtent: 32, //height of current item
            scrollController: scrollController,
            children: List.generate(widget.contentList.length, (index) {
              final item = widget.contentList[index];
              return Center(
                  child: Text(
                item.data.toString(),
                style: TextStyle(
                  fontSize: 24,
                ),
              ));
            }),

            onSelectedItemChanged: (int value) {
              widget.textController.text =
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
}
