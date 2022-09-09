import 'package:flutter/material.dart';
import 'package:untitled/components/widgets/custom_text.dart';
import 'package:untitled/constants/my_colors.dart';

class CustomSimpleButton extends StatefulWidget {
  CustomSimpleButton({
    Key? key,
    required this.label,
    this.bgColor = MyColors.selectedColor,
    this.txtColor = Colors.white,
    this.onHoverColor = MyColors.darkBlueColor,
    required this.onPress,
    required this.fontSize,
    this.padding = const EdgeInsets.only(
      left: 8,
      right: 8,
      top: 2,
      bottom: 2,
    ),
  }) : super(key: key);

  final String label;
  final Color bgColor, txtColor, onHoverColor;
  final Function onPress;
  final double fontSize;
  final EdgeInsets padding;
  bool isHovering = false;

  @override
  State<CustomSimpleButton> createState() => _CustomSimpleButtonState();
}

class _CustomSimpleButtonState extends State<CustomSimpleButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onPress(),
      child: MouseRegion(
        onEnter: (e) {
          setState(() {
            widget.isHovering = !widget.isHovering;
          });
        },
        onExit: (e) {
          setState(() {
            widget.isHovering = !widget.isHovering;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.isHovering ? widget.onHoverColor : widget.bgColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffe0e0e0),
                blurRadius: 6,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: widget.padding,
            child: MyText.drawText(
              content: widget.label,
              fontColor: widget.txtColor,
              fontSize: widget.fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
