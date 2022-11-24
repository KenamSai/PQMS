import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String role ="";
  @override
  void initState() {
    super.initState();
    initial();
  }
  
   Future<void> initial() async {
    String temp =
        await SharedPreferencesClass().readTheData(PreferenceConst.username);
    print("temp:" + temp);
    setState(() {
      role = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "assets/app_icon.png",
                  height: 60,
                  width: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 3),
                child: Text(
                  role,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                "Inspector",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
            Colors.green.shade900,
            Colors.green.shade700,
            Colors.green.shade600
          ])),
        ),
        ListTile(
          leading: Icon(
            Icons.space_dashboard_rounded,
            color: Colors.black,
          ),
          title: Text("Dashboard"),
        ),
        ListTile(
          leading: Icon(
            Icons.notes,
            color: Colors.black,
          ),
          title: Text("Privacy Policy"),
        ),
        ListTile(
          leading: Icon(
            Icons.info,
            color: Colors.black,
          ),
          title: Text("App Info"),
        ),
        ListTile(
          leading: Image.asset(
            "assets/exit.png",
            height: 20,
            width: 20,
          ),
          title: Text("Exit"),
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.black,
          ),
          title: Text("LogOut"),
        ),
      ]),
    );
  }
}


