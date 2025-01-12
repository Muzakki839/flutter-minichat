import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
  });

  final String label;
  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return TextField(
      decoration: InputDecoration(
        label: Text(widget.label),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: GestureDetector(
          child: Icon(
            obscureText ? Icons.visibility_off_outlined : Icons.visibility,
          ),
          onTap: () => toggleObscureText(),
        ),
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
      obscureText: obscureText,
      controller: widget.controller,
    );
  }
}
