import 'package:flutter/material.dart';
import '../resources/color_manager.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    required this.textEditingController,
    this.labelText,
    required this.hintText,
    this.maxLength,
    this.prefixText,
    this.keyboardType,
    this.readOnly,
  });

  final TextEditingController textEditingController;
  final int? maxLength;
  final String hintText;
  final String? labelText;
  final String ?prefixText;
  final TextInputType ?keyboardType;
  final bool ?readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      controller: textEditingController,
      cursorColor: ColorManager.blackColor,
      keyboardType: keyboardType,
      readOnly: readOnly??false,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        counter: Container(),
        prefixText: prefixText,
        hintText: hintText,
        contentPadding: EdgeInsets.all(13),
        labelText: labelText,
        labelStyle:   TextStyle(color: ColorManager.blackColor),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
      ),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide:  BorderSide(color: ColorManager.blackColor),
  );
}