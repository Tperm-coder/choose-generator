import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/constants/my_colors.dart';

class TextInputOptions extends StatelessWidget {
  final TextEditingController controller;
  const TextInputOptions({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.selectedColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 620,
              width: 650,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsetsDirectional.only(start: 10.0),
                  ),
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLines: 100,
                  cursorColor: MyColors.selectedColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
