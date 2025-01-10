import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
    this.scale = 1,
  });

  final double scale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Transform.scale(
      scale: scale,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chat,
            color: theme.primary,
            size: 20,
          ),
          SizedBox(width: 2),
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
      ),
    );
  }
}
