import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/reusable/alert_dailog.dart';
import 'package:pqms/reusable/alert_withtwo_buttons.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String role = "";
  String versionNumber = "";
  @override
  void initState() {
    super.initState();
    getVersionNumber();
    initial();
  }

  getVersionNumber() async {
    final value = await SharedPreferencesClass()
        .readTheData(PreferenceConst.versionNumber);
    setState(() {
      versionNumber = value;
    });
  }

  Future<void> initial() async {
    String temp =
        await SharedPreferencesClass().readTheData(PreferenceConst.username);
    //print("temp:" + temp);
    setState(() {
      role = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Stack(children: [
          ListView(
            children: [
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
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ExactAssetImage("assets/bg.png"),
                  ),
                ),
              ),
              ListTile(
                onTap: (() {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName("/Dashboard"),
                  );
                }),
                leading: Icon(
                  Icons.space_dashboard_rounded,
                  color: Colors.black,
                ),
                title: Text("Dashboard"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.privacy);
                },
                leading: Icon(
                  Icons.notes,
                  color: Colors.black,
                ),
                title: Text("Privacy Policy"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context,AppRoutes.appinfo);
                },
                leading: Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                title: Text("App Info"),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialogBoxTwoButtons(title: "UAT-PQMS", 
                      descriptions: "Do you want to exit from app?", 
                      Buttontext1: "Yes", 
                      Buttontext2: "No", 
                      img: Image.asset("assets/warning.png") , 
                      onButton1Pressed: (() {
                         SystemNavigator.pop();
                      }), 
                      onButton2Pressed:(() {
                         Navigator.of(context).pop(false);
                      }));
                      // return AppAlertDailog(
                      //   titleTextColor: customColors.colorPQMS,
                      //   title: "UAT-PQMS",
                      //   message: "Do you want to exit from app?",
                      //   icon: Icons.error,
                      //   yestitle: "Yes",
                      //   notitle: "No",
                      //   iconColor: Colors.red,
                      //   YesonPressed: (() {
                      //     SystemNavigator.pop();
                      //   }),
                      //   NoonPressed: () {
                      //     Navigator.of(context).pop(false);
                      //   },
                      // );
                    },
                  );
                },
                leading: Image.asset(
                  "assets/exit.png",
                  height: 20,
                  width: 20,
                ),
                title: Text("Exit"),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialogBoxTwoButtons(title: "UAT-PQMS", 
                      descriptions: "Do you want to logout from app?", 
                      Buttontext1: "Yes", 
                      Buttontext2: "No", 
                      img: Image.asset("assets/warning.png") , 
                      onButton1Pressed: (() {
                         Navigator.popUntil(
                              context, ModalRoute.withName(AppRoutes.Login));
                      }), 
                      onButton2Pressed:(() {
                         Navigator.of(context).pop(false);
                      }));
                     
                    },
                  );
                },
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text("LogOut"),
              ),
              
            ],
          ),
       
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
                  "Version: uat $versionNumber",
                  style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                ),
          ),
        ]),
      ),
    );
  }
}
