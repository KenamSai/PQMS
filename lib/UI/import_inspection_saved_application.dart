import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/import_inspection_response.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/routes/AppRoutes.dart';


class ImportInspectionSavedApplications extends StatefulWidget {
  const ImportInspectionSavedApplications({super.key});

  @override
  State<ImportInspectionSavedApplications> createState() => _ImportInspectionSavedApplicationsState();
}

class _ImportInspectionSavedApplicationsState extends State<ImportInspectionSavedApplications> {
    List<ImportResponseinspectionModelClass> importdata=[];

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
        backgroundColor: Color.fromARGB(255, 22, 99, 24),
        title: Text('UAT-PQMS'
        ),
        actions: [
          GestureDetector(
            onTap: null,
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.importinspectionformsubmit,
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
        .queryAllRows(DatabaseHelper.ImportInspectiontable)
        .then((value) {
      setState(() {
        for (var element in value) {
          var model = ImportResponseinspectionModelClass(
            applicationId: element["applicationId"],
            InspectionDate: element["InspectionDate"],
            Dutyofficer: element["Dutyofficer"],
            InspectionPlace: element["InspectionPlace"],
            InspectionRemarks: element["InspectionRemarks"],
            userimage1: element["userimage1"],
            userimage2: element["userimage2"],
            userimage3: element["userimage3"]
             
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

