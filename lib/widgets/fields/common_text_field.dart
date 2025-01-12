import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onSubmitted,
  });

  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: theme.onPrimary),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      style: TextStyle(color: theme.onPrimary), // Set input text color
      cursorColor: theme.onPrimary,
      onSubmitted: onSubmitted,
      controller: controller,
    );
  }
}
