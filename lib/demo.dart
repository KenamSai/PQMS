import 'package:flutter/material.dart';

import 'package:pqms/reusable/backgroundImage.dart';

class demo extends StatefulWidget {
  const demo({super.key});

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("PQMS"),
      ),
      body: backgroundReusable(
        child: Text("sai"),
      ),
    );
  }
}
