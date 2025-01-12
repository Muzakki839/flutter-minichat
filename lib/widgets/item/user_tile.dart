// import 'dart:math';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return ListTile(
      leading: CircleAvatar(
        // backgroundColor: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withAlpha(255),
        backgroundColor: theme.tertiary,
        child: Icon(Icons.person, color: theme.onPrimary),
      ),
      title: Text(text, style: TextStyle(color: theme.scrim)),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
