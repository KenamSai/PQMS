import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardComponent extends StatelessWidget {
  const CardComponent({super.key,required this.TextData,required this.icon});

 final String TextData;
 final String icon;
  @override
  Widget build(BuildContext context) {
    return   Card(
                      margin: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          icon,
                          height: 45,
                          width: 45,
                          color: Color.fromARGB(255, 120, 17, 7),
                        ),
                        title: Text(
                          TextData,
                          style:
                              TextStyle(color: Colors.green[900], fontSize: 20),
                        ),
                      ),
                    );
  }
}