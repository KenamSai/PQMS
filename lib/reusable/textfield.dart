import 'package:flutter/material.dart';

class TextComponenet extends StatelessWidget {
  const TextComponenet(
      {super.key,
      required this.labeltext,
      this.icon,
      required this.controller, 
      });
  final String labeltext;
   final Icon? icon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labeltext,
              labelStyle: TextStyle(
                color: Colors.green,
              ),
              //suffixIcon: IconButton,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.green.shade700, width: 3.0),
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
