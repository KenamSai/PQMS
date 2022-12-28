import 'package:flutter/material.dart';
import 'package:pqms/reusable/CustomColors.dart';

class SingleButtonAlertDailog extends StatelessWidget {
  const SingleButtonAlertDailog({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.textColor,
    this.titleTextColor,
    this.iconColor,
    required this.oktitle,
    this.okonPressed,
  });

  final String title;
  final String message;
  final IconData icon;
  final Color? textColor;
  final Color? titleTextColor;
  final Color? iconColor;
  final String oktitle;
  final void Function()? okonPressed;
 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: titleTextColor ?? Colors.green,
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
        SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: ElevatedButton(
            onPressed: this.okonPressed ,
            child: Text(oktitle),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(customColors.colorPQMS),
            ),
          ),
        )
      ],
    );
  }
}
