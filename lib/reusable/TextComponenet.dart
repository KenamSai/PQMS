import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextComponent extends StatelessWidget {
  const TextComponent(
      {super.key, required this.TextData, required this.fontSize});

  final String TextData;
  final double fontSize;
  
  @override
  Widget build(BuildContext context) {
    return Text(
      TextData,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: fontSize),
    );
  }
}