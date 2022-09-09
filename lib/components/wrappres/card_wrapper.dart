import 'package:flutter/material.dart';
import 'package:untitled/constants/my_colors.dart';

class CardWrapper extends StatelessWidget {
  final Widget child;
  const CardWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.containerColor,
          ),
          child: child,
        ),
      ),
    );
  }
}
