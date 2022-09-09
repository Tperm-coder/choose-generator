import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/widgets/custom_text.dart';
import 'package:untitled/constants/my_colors.dart';

void showPopUpText(BuildContext context, String content,
    {bool popOnIgnore = true}) {
  showDialog(
    barrierDismissible: popOnIgnore,
    context: context,
    builder: (_) {
      return Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(90),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: MyText.drawText(
                  content: content,
                  fontSize: 25,
                  fontColor: Colors.black,
                  bold: true,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showPopUpWidget(
  BuildContext context,
  Widget child, {
  Function? thenFunction,
  bool disablePadding = false,
  bool popOnIgnore = true,
}) async {
  return await showDialog(
    barrierDismissible: popOnIgnore,
    context: context,
    builder: (_) {
      return Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: EdgeInsets.all(!disablePadding ? 50.0 : 0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(90),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return child;
                  },
                ),
              ),
            ),
          ),
        ),
      );
    },
  ).then((_) {
    if (thenFunction != null) {
      thenFunction();
    }
  });
}

Future<bool> showConfirmPopUp(BuildContext context) async {
  bool confirmed = false;
  await showPopUpWidget(
    context,
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            confirmed = true;
            Navigator.of(context).pop();
          },
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.selectedColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyText.drawText(
                content: "تاكيد",
                fontSize: 25,
                fontColor: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 75,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyText.drawText(
                content: "الغاء",
                fontSize: 25,
                fontColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  return confirmed;
}

void showSnackBarPopUp(
  BuildContext context,
  String content, {
  Color txtClr = Colors.white,
  Color bgClr = MyColors.darkBlueColor,
  Function? onThenFunction,
}) {
  Flushbar(
    messageColor: txtClr,
    backgroundColor: bgClr,
    messageText: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MyText.drawText(
          content: content,
          fontColor: Colors.white,
          fontSize: 25.5,
        ),
      ],
    ),
    duration: const Duration(milliseconds: 2000),
  ).show(context).then(
    (value) {
      if (onThenFunction != null) {
        onThenFunction();
      }
    },
  );
}
