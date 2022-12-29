import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/exportInspectionResponseModelClass.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/routes/AppRoutes.dart';

class exportInspectionSaved extends StatefulWidget {
  const exportInspectionSaved({super.key});

  @override
  State<exportInspectionSaved> createState() => _exportInspectionSavedState();
}

class _exportInspectionSavedState extends State<exportInspectionSaved> {
  List<exportResponseinspectionModelClass> ListData = [];
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.instance.queryAllRows("ExportInspectionEntry").then((value) {
      setState(() {
        value.forEach((element) {
          ListData.add(
            exportResponseinspectionModelClass(
                dutyofficerId: element["DutyOfficerId"],
                applicationId: element["applicationId"],
                inspectionDate: element["InspectionDate"],
                dutyofficer: element["Dutyofficer"],
                inspectionPlace: element["InspectionPlace"],
                inspectionRemarks: element["InspectionRemarks"],
                noofSamples: element["NoofSamples"],
                sampleSize: element["SampleSize"],
                userimage1: element["userimage1"],
                userimage2: element["userimage2"],
                userimage3: element["userimage3"],
                inspctArea: element["inspctArea"],
                inspctLocation: element["inptLocation"]),
          );
        });
      });
    }).catchError((error) {
      print("Error is :$error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("UAT-PQMS"),
        backgroundColor: customColors.colorPQMS,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName("/Dashboard"),
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
                  "Export Inspection Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListData.isEmpty
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
                      itemCount: ListData.length,
                      itemBuilder: (context, index) {
                        final data = ListData[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.exportinspectionSubmission,
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
                                  "Application Date",
                                  data.inspectionDate,
                                ),
                                RowComponent(
                                  "Duty Officer",
                                  data.dutyofficer,
                                ),
                                RowComponent(
                                  "No of Samples",
                                  data.noofSamples,
                                ),
                                RowComponent(
                                  "Remarks",
                                  data.inspectionRemarks,
                                ),
                                RowComponent(
                                  "Location",
                                  data.inspctLocation,
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
