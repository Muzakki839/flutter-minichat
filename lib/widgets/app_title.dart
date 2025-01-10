import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.chat,
          color: theme.primary,
        ),
        SizedBox(width: 3),
        Text(
          "Mini",
          style: TextStyle(
            color: theme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Chat",
          style: TextStyle(
            color: theme.primary,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
