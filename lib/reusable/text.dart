import 'package:flutter/material.dart';

class TextC extends StatelessWidget {
  const TextC(
      {super.key,
      required this.labeltext,
      //required this.IconButton,
      this.controller, 
      });
  final String labeltext;
  //final  IconButton ;
  final controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labeltext,
              labelStyle: TextStyle(
                color: Colors.green,
              ),
              //suffixIcon: IconButton,
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
