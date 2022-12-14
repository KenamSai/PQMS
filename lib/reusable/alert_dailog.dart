import 'package:flutter/material.dart';
import 'package:pqms/reusable/CustomColors.dart';

class AppAlertDailog extends StatelessWidget {
  const AppAlertDailog({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.textColor,
    this.titleTextColor,
    this.iconColor,
    this.yestitle,
    this.notitle,
    this.YesonPressed,
    this.NoonPressed,
  
  });

  final String title;
  final String message;
  final IconData icon;
  final Color? textColor;
  final Color? titleTextColor;
  final Color? iconColor;
  final String? yestitle;
  final String? notitle;
  final void Function()? YesonPressed;
  final void Function()? NoonPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
      title: Text(
        title,
        style: TextStyle(
          color: titleTextColor ?? customColors.colorPQMS,
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
            ElevatedButton(
              onPressed:YesonPressed,
              child: Text(yestitle!),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(customColors.colorred),
              ),
            ),
            ElevatedButton(
              onPressed: NoonPressed,
              child: Text(notitle!),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(customColors.colorPQMS),
              ),
            )
        
          ],
        )
      ],
    );
  }
}
