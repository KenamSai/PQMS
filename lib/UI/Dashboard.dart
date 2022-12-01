import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/reusable/Card_Component.dart';
import 'package:pqms/UI/SideBar.dart';
import 'package:pqms/reusable/Text_Component.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? rolename ;

  @override
  initState() {
    super.initState();
    initial();
    // print("init:$rolename");
  }

  initial() async {
    String temp =
        await SharedPreferencesClass().readTheData(PreferenceConst.username);
    //print("temp:" + temp);
    setState(() {
      rolename = temp;
      //print("rolename:$rolename");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[900],
        title: Text(
          "UAT-PQMS",
        ),
        actions: [
          GestureDetector(
            onTap: null,
            child: Image.asset(
              "assets/logout.png",
              height: 30,
              width: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: FittedBox(
                  child: Text(
                    "Plant Quarantine Management System",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Image.asset(
                "assets/app_icon.png",
                height: 90,
                width: 90,
              ),
              SizedBox(
                height: 10,
              ),
              TextComponent(
                TextData: rolename ?? "",
                fontSize: 20,
              ),
              SizedBox(
                height: 5,
              ),
              TextComponent(
                TextData: "Inspector",
                fontSize: 18,
              ),
              Center(
                child: Card(
                  color: Colors.black.withOpacity(0.1),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (() async{
                           await EasyLoading.show(status: "Loading...",maskType: EasyLoadingMaskType.black);
                          Navigator.pushNamed(context, AppRoutes.importrelease);                   
                        }),
                        child: CardComponent(
                            TextData: "Import Release Order",
                            icon: "assets/import.png"),
                      ),
                      GestureDetector(
                        onTap: (()async {
                           await EasyLoading.show(status: "Loading...",maskType: EasyLoadingMaskType.black);
                          Navigator.pushNamed(context, AppRoutes.exportrelease);
                        }),
                        child: CardComponent(
                            TextData: "Export Applications",
                            icon: "assets/export.png"),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.pushNamed(context, AppRoutes.ViewSavedAppln);
                        }),
                        child: CardComponent(
                            TextData: "View Saved Applications",
                            icon: "assets/export.png"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Image.asset(
        "assets/headerpic.png",
        width: double.infinity,
        height: 40,
      ),
    );
  }
}
