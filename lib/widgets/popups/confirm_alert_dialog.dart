import 'package:flutter/material.dart';

class ConfirmAlertDialog extends StatelessWidget {
  const ConfirmAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.yesButtonText,
    required this.yesButtonColor,
    this.onTapYes,
  });

  final Widget title;
  final Widget content;
  final String yesButtonText;
  final Color yesButtonColor;

  final void Function()? onTapYes;

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
            overlayColor: WidgetStateProperty.all(Colors.black12),
          ),
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            onTapYes;
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.black12),
          ),
          child: Text(
            yesButtonText,
            style: TextStyle(color: yesButtonColor),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );
  }
}
