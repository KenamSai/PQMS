import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({super.key});

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  String versionNumber = "";
  String versionDate="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: customColors.colorPQMS,
        title: Text(
          "App Info",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName(AppRoutes.dashboardpage),
              );
            },
            child: Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage(
              "assets/bg.png",
            ),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Image.asset("assets/appLogo.png"),
              width: 100,
              height: 100,
            ),
            SizedBox(
              height: 30,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Version   ",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),
                  ),
                  TextSpan(
                    text: versionNumber,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),
                  )
                ],
              ),
            ),
             SizedBox(
              height: 20,
            ),
             RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Updated On   ",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),
                  ),
                  TextSpan(
                    text: "$versionDate",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getVersionNumber();
  }

  getVersionNumber() async {
    final value = await SharedPreferencesClass()
        .readTheData(PreferenceConst.versionNumber);
    final date=await SharedPreferencesClass().readTheData(PreferenceConst.versionUpdateDate);
    setState(() {
      versionNumber = value;
      versionDate=date;
    });
  }
}
