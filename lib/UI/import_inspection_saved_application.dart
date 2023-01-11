import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/import_inspection_response.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/reusable/alert_dailog.dart';
import 'package:pqms/reusable/alert_withtwo_buttons.dart';
import 'package:pqms/routes/AppRoutes.dart';

class ImportInspectionSavedApplications extends StatefulWidget {
  const ImportInspectionSavedApplications({super.key});

  @override
  State<ImportInspectionSavedApplications> createState() =>
      _ImportInspectionSavedApplicationsState();
}

class _ImportInspectionSavedApplicationsState
    extends State<ImportInspectionSavedApplications> {
  List<ImportResponseinspectionModelClass> importdata = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance
        .queryAllRows(DatabaseHelper.ImportInspectiontable)
        .then((value) {
      setState(() {
        for (var element in value) {
          var model = ImportResponseinspectionModelClass(
              applicationId: element["applicationId"],
              InspectionDate: element["InspectionDate"],
              NoofSamples: element["NoofSamples"],
              SampleSize: element["SampleSize"],
              Dutyofficer: element["Dutyofficer"],
              DutyOfficerId: element["DutyOfficerId"],
              InspectionPlace: element["InspectionPlace"],
              InspectionRemarks: element["InspectionRemarks"],
              QuantityFound: element["QuantityFound"],
              inptLocation: element["inptLocation"],
              inspctArea: element["inspctArea"],
              userimage1: element["userimage1"],
              userimage2: element["userimage2"],
              userimage3: element["userimage3"]);
          importdata.add(model);
          //print(userData);
        }
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: customColors.colorPQMS,
        title: Text('UAT-PQMS'),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogBoxTwoButtons(
                  title: "UAT-PQMS",
                  descriptions: "Do you want to logout from app?",
                  Buttontext1: "Yes",
                  Buttontext2: "No",
                  img: Image.asset("assets/warning.png"),
                  onButton1Pressed: (() {
                    Navigator.popUntil(
                        context, ModalRoute.withName(AppRoutes.Login));
                  }),
                  onButton2Pressed: (() {
                    Navigator.of(context).pop(false);
                  }));
                  // AppAlertDailog(
                  //   iconColor: Colors.red,
                  //   titleTextColor: customColors.colorPQMS,
                  //   title: "UAT-PQMS",
                  //   message: "Do you want to logout from app?",
                  //   icon: Icons.error,
                  //   yestitle: "Yes",
                  //   notitle: "No",
                  //   YesonPressed: () {
                  //     Navigator.popUntil(
                  //         context, ModalRoute.withName(AppRoutes.Login));
                  //   },
                  //   NoonPressed: () {
                  //     Navigator.of(context).pop(false);
                  //   },
                  // );
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
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage("assets/bg.png"),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Import Inspection Applications",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            importdata.isEmpty
                ? Expanded(
                    flex: 18,
                    child: Center(
                      child: Text(
                        "No Application Available",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    flex: 18,
                    child: ListView.builder(
                      itemCount: importdata.length,
                      itemBuilder: (context, index) {
                        final data = importdata[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.importinspectionformsubmit,
                                arguments: data);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                RowComponent(
                                  "Application Id",
                                  data.applicationId,
                                ),
                                RowComponent(
                                  "Inspection Date",
                                  data.InspectionDate,
                                ),
                                RowComponent(
                                  "Duty Officer",
                                  data.Dutyofficer,
                                ),
                                RowComponent(
                                  "Inspection Place",
                                  data.InspectionPlace,
                                ),
                                RowComponent(
                                  "Inspection Remarks",
                                  data.InspectionRemarks,
                                ),
                                RowComponent(
                                  "Application Saved Date",
                                  data.InspectionDate,
                                ),
                                RowComponent(
                                  "Inspection Location",
                                  data.inptLocation,
                                ),
                                RowComponent(
                                  "No of Samples",
                                  data.NoofSamples,
                                ),
                                RowComponent(
                                  "Sample Size",
                                  data.SampleSize,
                                ),
                                RowComponent(
                                  "Quantity Found",
                                  data.QuantityFound,
                                ),
                                RowComponent(
                                  "Employ ID ",
                                  data.DutyOfficerId,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 10, bottom: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(fontSize: 17),
            ),
          )
        ],
      ),
    );
  }
}
