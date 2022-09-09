import 'package:flutter/material.dart';

class MyText {
  static Widget drawText({
    String content = "Test",
    double fontSize = 12,
    Color fontColor = Colors.black26,
    bool bold = false,
    bool centered = false,
    bool isUnderlined = false,
    bool isSelectable = false,
  }) {
    TextStyle style = TextStyle(
      fontFamily: "Cairo",
      color: fontColor,
      fontSize: fontSize,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      decoration: isUnderlined ? TextDecoration.underline : null,
    );
    return isSelectable
        ? SelectableText(
            content,
            style: style,
            textAlign: centered ? TextAlign.center : TextAlign.start,
            toolbarOptions: const ToolbarOptions(
              copy: true,
              selectAll: true,
              cut: false,
              paste: false,
            ),
          )
        : Text(
            content,
            style: style,
            textAlign: centered ? TextAlign.center : TextAlign.start,
          );
  }
}
