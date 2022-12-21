import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/exporttreatmentresponsemodel.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/routes/AppRoutes.dart';

class exportTreatmentSaved extends StatefulWidget {
  const exportTreatmentSaved({super.key});

  @override
  State<exportTreatmentSaved> createState() => _exportTreatmentSavedState();
}

class _exportTreatmentSavedState extends State<exportTreatmentSaved> {
  List<exporttreatmentresponsemodelclass> TreatmentData = [];
  initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.instance.queryAllRows("ExportTreatment").then((value) {
      setState(() {
        value.forEach((element) {
          TreatmentData.add(
            exporttreatmentresponsemodelclass(
              applicationId: element["applicationId"],
              chemicals: element["Chemicals"],
              completionDate: element["CompletionDate"],
              doneby: element["Doneby"],
              dosage: element["Dosage"],
              durationHrs: element["Duration"],
              dutyofficer: element["Dutyofficer"],
              temperatureDegC: element["Temperature"],
              treatmentDate: element["TreatmentDate"],
              treatmentRemarks: element["TreatmentRemarks"],
              dutyofficerId: element["DutyOfficerId"],
              agencyId: element["AgencyId"]
            ),
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
        backgroundColor: Colors.green[900],
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
              size: 50,
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
                  "Export Treatment Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            TreatmentData.isEmpty
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
                      itemCount: TreatmentData.length,
                      itemBuilder: (context, index) {
                        final data = TreatmentData[index];
                        return GestureDetector(
                          onTap: (() {
                            Navigator.pushNamed(
                                context, AppRoutes.exporttreatmentSubmission,
                                arguments:data);
                          }),
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
                                  "Chemicals",
                                  data.chemicals,
                                ),
                                RowComponent(
                                  "Duty Officer",
                                  data.dutyofficer,
                                ),
                                RowComponent(
                                  "Treatment Date",
                                  data.treatmentDate,
                                ),
                                RowComponent(
                                  "Dosage",
                                  data.dosage,
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
