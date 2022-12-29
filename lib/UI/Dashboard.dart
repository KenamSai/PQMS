import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/Card_Component.dart';
import 'package:pqms/UI/SideBar.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/reusable/TextComponenet.dart';
import 'package:pqms/reusable/alert_dailog.dart';
import 'package:pqms/reusable/singlebutton_alert.dart';
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
            builder: (context) => AlertDialog(
              icon: Icon(Icons.error,color: Colors.red,size: 50,),
              title: Text(
                "UAT-PQMS",
                style: TextStyle(color: customColors.colorPQMS),
              ),
              content: Text(
                'Do you want to exit App?',
                textAlign: TextAlign.center,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      //return false when click on "NO"
                      child: Text('No'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            customColors.colorPQMS),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => SystemNavigator.pop(),
                      //return true when click on "Yes"
                      child: Text('Yes'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            customColors.colorred),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ) ??
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
              onTap:() {
                showDialog(
              context: context,
              builder: (context) {
                return AppAlertDailog(
                  iconColor: Colors.red,
                  titleTextColor: Colors.black,
                  title: "UAT-PQMS",
                  message: "Do you want to logout from app?",
                  icon: Icons.error,
                  yestitle: "Yes",
                  notitle: "No",
                  YesonPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName(AppRoutes.Login));
                  },
                  NoonPressed: () {
                    Navigator.of(context).pop(false);
                  },
                );
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
                            await EasyLoading.show(
                                status: "Loading...",
                                maskType: EasyLoadingMaskType.black);
                            Navigator.pushNamed(
                                context, AppRoutes.importrelease);
                          }),
                          child: CardComponent(
                              TextData: "Import Release Order",
                              icon: "assets/import.png"),
                        ),
                        GestureDetector(
                          onTap: (() async {
                            await EasyLoading.show(
                                status: "Loading...",
                                maskType: EasyLoadingMaskType.black);
                            Navigator.pushNamed(
                                context, AppRoutes.exportrelease);
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
          return AppAlertDailog(
            title: "UAT-PQMS",
            message:
                "Saved Inspection/Treatment data found related to others.Do you want to clear?",
            icon: Icons.error,
            iconColor: Colors.red,
            yestitle: "Yes",
            YesonPressed: () async {
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
              showAlert();
            },
            NoonPressed: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName(AppRoutes.Login),
              );
            },
            notitle: "NO",
          );
        },
      );
    }
  }

  showAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return SingleButtonAlertDailog(
          title: "UAT-PQMS",
          iconColor: customColors.colorPQMS,
          message: "Data Deleted Successfully",
          icon: Icons.done_outline,
          oktitle: "Ok",
          okonPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
