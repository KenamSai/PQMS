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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
      title: Text(
        title,
        style: TextStyle(
          color: titleTextColor ??customColors.colorPQMS,
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
          fontSize: 16
        ),
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: ElevatedButton(
            onPressed: this.okonPressed ,
            child: Text(oktitle,style: TextStyle(color: Colors.white),),
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
