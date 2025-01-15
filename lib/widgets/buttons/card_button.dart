import 'package:flutter/material.dart';

class CardButton extends StatefulWidget {
  const CardButton({
    super.key,
    this.text,
    this.onTap,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String? text;
  final Icon? icon;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  bool _isPressed = false;

  void _updateState(bool isPressed) {
    setState(() {
      _isPressed = isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _updateState(true),
      onTapUp: (_) => _updateState(false),
      onTapCancel: () => _updateState(false),
      child: Transform.scale(
        scale: _isPressed ? 0.9 : 1,
        child: Card.outlined(
          elevation: _isPressed ? 0 : 10,
          color: widget.backgroundColor ?? Colors.white,
          child: Center(
            child: widget.icon ??
                Text(
                  widget.text ?? "",
                  style: TextStyle(
                    fontSize: 30,
                    color: widget.foregroundColor ?? Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
