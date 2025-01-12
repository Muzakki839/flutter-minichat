import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  const IconTextField({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.controller,
  });

  final String label;
  final Icon prefixIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return TextField(
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: prefixIcon,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.primary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10)),
      ),
      controller: controller,
    );
  }
}
