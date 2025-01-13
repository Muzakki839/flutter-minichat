import 'package:flutter/material.dart';

class GridTileButton extends StatelessWidget {
  const GridTileButton({
    super.key,
    required this.nameText,
    required this.onTap,
    required this.icon,
    this.iconColor,
  });

  final String nameText;
  final IconData icon;
  final Color? iconColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return IconButton(
      onPressed: onTap,
      icon: Column(
        children: [
          Expanded(
            child: Icon(
              icon,
              size: 70,
              color: iconColor ?? theme.primary,
            ),
          ),
          Text(
            nameText,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
