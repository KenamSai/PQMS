import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class reusableAlert extends StatelessWidget {
  const reusableAlert(
      {super.key,
      required this.title,
      required this.message,
      required this.icon,
      this.textColor,
      this.titleTextColor,
      this.iconColor});

  final String title;
  final String message;
  final IconData icon;
  final Color? textColor;
  final Color? titleTextColor;
  final Color? iconColor;
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
    );
  }
}
