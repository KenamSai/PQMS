import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextReusable extends StatelessWidget {
  const TextReusable({
    super.key,
    required this.data,
    required this.controller,
    this.requiredData, 
    this.maxlines, 
    this.readType, 
    this.format, 
    this.keyboardtype,
     
  });
  final List<TextInputFormatter>? format;
  final String data;
  final TextEditingController controller;
  final String? requiredData;
  final int? maxlines;
  final bool? readType;
  final TextInputType? keyboardtype;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        keyboardType: keyboardtype,
        inputFormatters:format ?? [],
        readOnly: readType ?? false,
        controller: controller,
        cursorColor: Colors.green.shade600,
        textInputAction: TextInputAction.done,
        maxLines: maxlines,
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
