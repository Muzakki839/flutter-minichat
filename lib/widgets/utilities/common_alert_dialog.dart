import 'package:flutter/material.dart';

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.buttonColor,
  });

  final Widget title;
  final Widget content;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(buttonColor),
          ),
          child: Text(
            "OK",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      actionsPadding: EdgeInsets.all(10),
    );
  }
}
