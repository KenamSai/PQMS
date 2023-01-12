import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/Card_Component.dart';
import 'package:pqms/UI/SideBar.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/reusable/TextComponenet.dart';
import 'package:pqms/reusable/alertWithButtonDone.dart';
import 'package:pqms/reusable/alert_singlebutton.dart';
import 'package:pqms/reusable/alert_withtwo_buttons.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? rolename;

  @override
  initState() {
    super.initState();
    usercheck();
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
    Future<bool> showExitPopup() async {
      return await showDialog(
              context: context,
              builder: (context) => CustomDialogBoxTwoButtons(
                  title: "UAT-PQMS",
                  descriptions: "Do you want to logout from app?",
                  Buttontext1: "No",
                  Buttontext2: "Yes",
                  img: Image.asset("assets/warning.png"),
                  onButton1Pressed: (() {
                    Navigator.of(context).pop(false);
                  }),
                  onButton2Pressed: (() {
                    Navigator.popUntil(
                        context, ModalRoute.withName(AppRoutes.Login));
                  }))) ??
          false; //if showDialouge had returned null, then return false
      //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        drawer: SideBar(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: customColors.colorPQMS,
          title: Text(
            "UAT-PQMS",
          ),
          actions: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialogBoxTwoButtons(
                        title: "UAT-PQMS",
                        descriptions: "Do you want to logout from app?",
                        Buttontext1: "No",
                        Buttontext2: "Yes",
                        img: Image.asset("assets/warning.png"),
                        onButton1Pressed: (() {
                          Navigator.of(context).pop(false);
                        }),
                        onButton2Pressed: (() {
                          Navigator.popUntil(
                              context, ModalRoute.withName(AppRoutes.Login));
                        }));
                  },
                );
              },
              child: Image.asset(
                "assets/logout.png",
                height: 20,
                width: 20,
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
                          onTap: (() async {
                            var result =
                                await Connectivity().checkConnectivity();
                            if (result == ConnectivityResult.mobile ||
                                result == ConnectivityResult.wifi) {
                              await EasyLoading.show(
                                  status: "Loading...",
                                  maskType: EasyLoadingMaskType.black);
                              Navigator.pushNamed(
                                  context, AppRoutes.importrelease);
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SingleButtonDialogBox(
                                      title: "UAT-PQMS",
                                      descriptions:
                                          "Please Check your Internet Connectivity",
                                      Buttontext: "Ok",
                                      img: Image.asset("assets/caution.png"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      });
                                },
                              );
                            }
                          }),
                          child: CardComponent(
                              TextData: "Import Release Order",
                              icon: "assets/import.png"),
                        ),
                        GestureDetector(
                          onTap: (() async {
                             var result =
                                await Connectivity().checkConnectivity();
                            if (result == ConnectivityResult.mobile ||
                                result == ConnectivityResult.wifi){
                            await EasyLoading.show(
                                status: "Loading...",
                                maskType: EasyLoadingMaskType.black);
                            Navigator.pushNamed(
                                context, AppRoutes.exportrelease);}
                                else{showDialog(
                                context: context,
                                builder: (context) {
                                  return SingleButtonDialogBox(
                                      title: "UAT-PQMS",
                                      descriptions:
                                          "Please Check your Internet Connectivity",
                                      Buttontext: "Ok",
                                      img: Image.asset("assets/caution.png"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      });
                                },
                              );}
                          }),
                          child: CardComponent(
                              TextData: "Export Applications",
                              icon: "assets/export.png"),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.pushNamed(
                                context, AppRoutes.ViewSavedAppln);
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
        bottomSheet: Container(
          child: Image.asset(
            "assets/headerpic.png",
            width: double.infinity,
            height: 40,
          ),
        ),
      ),
    );
  }

  usercheck() async {
    final actualId =
        await SharedPreferencesClass().readTheData(PreferenceConst.actualId);
    print("actualId  $actualId");
    final upcomingId =
        await SharedPreferencesClass().readTheData(PreferenceConst.upcomingId);
    print("upcomingId  $upcomingId");
    if (actualId == null) {
      await SharedPreferencesClass()
          .writeTheData(PreferenceConst.actualId, upcomingId);
    } else if (actualId != upcomingId) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBoxTwoButtons(
              title: "UAT-PQMS",
              descriptions:
                  "Saved Inspection/Treatment data found related to others.Do you want to clear?",
              Buttontext1: "No",
              Buttontext2: "Yes",
              img: Image.asset("assets/warning.png"),
              onButton1Pressed: (() async {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(AppRoutes.Login),
                );
              }),
              onButton2Pressed: (() async {
                await SharedPreferencesClass()
                    .writeTheData(PreferenceConst.actualId, upcomingId);

                DatabaseHelper _databasehelper = await DatabaseHelper.instance;
                await _databasehelper
                    .dropTable(DatabaseHelper.ExportInspectiontable);
                await _databasehelper
                    .dropTable(DatabaseHelper.exporttreatmenttable);
                await _databasehelper
                    .dropTable(DatabaseHelper.ImportInspectiontable);
                await _databasehelper
                    .dropTable(DatabaseHelper.ImportTreatmenttable);
                Navigator.pop(context);
                showAlert("Data Deleted Successfully");
              }));
        },
      );
    }
  }

  showAlert(msg) {
    showDialog(
      context: context,
      builder: (context) {
        return alertWithButton(
            title: "UAT-PQMS",
            descriptions: msg,
            Buttontext: "Ok",
            img: Image.asset("assets/correct.png"),
            onButtonPressed: () {
              Navigator.pop(context);
            });
      },
    );
  }
}
