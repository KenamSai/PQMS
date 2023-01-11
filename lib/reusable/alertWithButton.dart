import 'package:flutter/material.dart';
import 'package:pqms/reusable/CustomColors.dart';

class alertWithButton extends StatefulWidget {
  final String title, descriptions, Buttontext;
  final Image img;
 
  final void Function()? onButtonPressed;

  const alertWithButton({
    Key? key,
    required this.title,
    required this.descriptions,
    required this.Buttontext,
    required this.img,
    required this.onButtonPressed
   
  }) : super(key: key);

  @override
  _alertWithButtonState createState() =>
      _alertWithButtonState();
}

class _alertWithButtonState extends State<alertWithButton> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(customColors.colorPQMS),
                        minimumSize: MaterialStateProperty.all(Size(70, 30)),
                      ),
                      onPressed: widget.onButtonPressed,
                      child: Text(
                        widget.Buttontext,
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 30,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: widget.img),
          ),
        ),
      ],
    );
  }
}
