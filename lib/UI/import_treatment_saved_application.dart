import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/import_treatment_response.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/reusable/alert_dailog.dart';
import 'package:pqms/reusable/alert_withtwo_buttons.dart';
import 'package:pqms/routes/AppRoutes.dart';

class ImportTreatmentSavedApplications extends StatefulWidget {
  const ImportTreatmentSavedApplications({super.key});

  @override
  State<ImportTreatmentSavedApplications> createState() =>
      _ImportTreatmentSavedApplications();
}

class _ImportTreatmentSavedApplications
    extends State<ImportTreatmentSavedApplications> {
  List<ImportTreatmentModelClass> importdata = [];

  @override
  void initState() {
    showrecords();
    super.initState();
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
                  "Import Treatment Applications",
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
                                context, AppRoutes.importtreatmentformsubmit,
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
                                  "Duty Officer",
                                  data.Dutyofficer,
                                ),
                                RowComponent(
                                  "Treatment Date",
                                  data.TreatmentDate,
                                ),
                                RowComponent(
                                  "Completed Date",
                                  data.CompletedDate,
                                ),
                                RowComponent(
                                  "Treatment Remarks",
                                  data.TreatmentRemarks,
                                ),
                                RowComponent(
                                  "Application Saved Date",
                                  data.CompletedDate,
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

  void showrecords() {
    DatabaseHelper.instance
        .queryAllRows(DatabaseHelper.ImportTreatmenttable)
        .then((value) {
      setState(() {
        for (var element in value) {
          var model = ImportTreatmentModelClass(
              applicationId: element["applicationId"],
              Dutyofficer: element["Dutyofficer"],
              Chemicals: element["Chemicals"],
              Dosage: element["Dosage"],
              Duration: element["Duration"],
              Temperature: element["Temperature"],
              TreatmentDate: element["TreatmentDate"],
              CompletedDate: element["CompletedDate"],
              DoneBy: element["DoneBy"],
              TreatmentRemarks: element["TreatmentRemarks"],
              TreatmentLocation: element["TreatmentLocation"],
              TreatmentArea: element["TreatmentArea"],
              DutyOfficerId: element["DutyOfficerId"],
              agencyId: element["AgencyId"]);
          importdata.add(model);

          //print(userData);
        }
      });
    }).catchError((error) {
      print(error);
    });
  }
}
