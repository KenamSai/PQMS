import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class reusableAlert extends StatelessWidget {
  const reusableAlert(
      {super.key,
      required this.title,
      required this.message,
      required this.icon,
      this.textColor,
      this.titleTextColor,
      this.iconColor,
      this.Yes,
      this.No});

  final String title;
  final String message;
  final IconData icon;
  final Color? textColor;
  final Color? titleTextColor;
  final Color? iconColor;
  final String? Yes;
  final String? No;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: titleTextColor ?? Colors.blue,
        ),
      ),
      icon: Icon(
        icon,
        color: iconColor ?? Colors.black,
        size: 50,
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor ?? Colors.black,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: (() {
                SystemNavigator.pop();
              }),
              child: Text(Yes ?? ""),
            ),
            TextButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              child: Text(No ?? ""),
            )
          ],
        )
      ],
    );
  }
}
