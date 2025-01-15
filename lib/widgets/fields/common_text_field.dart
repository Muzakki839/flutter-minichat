import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onSubmitted,
    this.focusNode,
    this.textColor,
    this.backgroundColor,
    this.inputBorder,
    this.textAlign,
    this.keyboardType,
    this.onChanged,
  });

  final Color? textColor;
  final Color? backgroundColor;

  final InputBorder? inputBorder;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;

  final String hintText;
  final TextEditingController controller;

  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final FocusNode defaultFocusNode = FocusNode();

    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: textColor ?? theme.secondary),
        border: inputBorder ?? InputBorder.none,
        enabledBorder: inputBorder ?? InputBorder.none,
      ),
      style: TextStyle(color: textColor ?? theme.scrim), // Set input text color
      textAlign: textAlign ?? TextAlign.left,
      cursorColor: textColor ?? theme.scrim,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTapOutside: (event) {
        focusNode?.unfocus();
        defaultFocusNode.unfocus();
      },
      controller: controller,
      focusNode: focusNode ?? defaultFocusNode,
    );
  }
}
