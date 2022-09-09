import 'package:flutter/material.dart';

class MyText {
  static Text drawText({
    String content = "Test",
    double fontSize = 12,
    Color fontColor = Colors.black26,
    bool bold = false,
    bool centered = false,
    bool isRTL = true,
    bool isUnderlined = false,
  }) {
    return Text(
      content,
      style: TextStyle(
        fontFamily: "Cairo",
        color: fontColor,
        fontSize: fontSize,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        decoration: isUnderlined ? TextDecoration.underline : null,
      ),
      textAlign: centered ? TextAlign.center : TextAlign.start,
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
    );
  }
}
