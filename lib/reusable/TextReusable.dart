import 'package:flutter/material.dart';

class TextReusable extends StatelessWidget {
  const TextReusable({
    super.key,
    required this.data,
    required this.controller,
    this.requiredData,
  });
  final String data;
  final TextEditingController controller;
  final String? requiredData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        controller: controller,
        cursorColor: Colors.green.shade600,
        decoration: InputDecoration(
          label: RichText(
            text: TextSpan(
                text: data,
                style: TextStyle(color: Colors.green.shade600),
                children: [
                  TextSpan(
                    text: requiredData ?? "",
                    style: TextStyle(color: Colors.red),
                  )
                ]),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green.shade400),
          ),
        ),
      ),
    );
  }
}
