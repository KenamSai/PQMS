import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/import_treatment_response.dart';
import 'package:pqms/db/DatabaseHelper.dart';


class ImportTreatmentSavedApplications extends StatefulWidget {
  const ImportTreatmentSavedApplications({super.key});

  @override
  State<ImportTreatmentSavedApplications> createState() => _ImportTreatmentSavedApplications();
}

class _ImportTreatmentSavedApplications extends State<ImportTreatmentSavedApplications> {
    List<ImportTreatmentModelClass> importdata=[];

     @override
  void initState() {
    super.initState();

    showrecords();
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
              size: 40,
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
                  "Import Treatment Applications",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
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
                        return Card(
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
            TreatmentDate: element["TreatmentDate"],
            CompletedDate: element["CompletedDate"],
            TreatmentRemarks: element["TreatmentRemarks"],
          );
          importdata.add(model);
          
          //print(userData);
        }
      });
    }).catchError((error) {
      print(error);
    });
  }

}

