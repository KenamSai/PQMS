import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pqms/ModelClass/import_treatment.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/TextReusable.dart';

class ImportTreatmentForm extends StatefulWidget {
  const ImportTreatmentForm({super.key});

  @override
  State<ImportTreatmentForm> createState() => _ImportTreatmentForm();
}

class _ImportTreatmentForm extends State<ImportTreatmentForm> {
  TextEditingController _Dutyofficer = TextEditingController();
  TextEditingController _Chemicals = TextEditingController();
  TextEditingController _Dosage = TextEditingController();
  TextEditingController _Duration = TextEditingController();
  TextEditingController _Temperature = TextEditingController();
  TextEditingController _TreatmentDate = TextEditingController();
  TextEditingController _CompletedDate = TextEditingController();
  TextEditingController _DoneBy = TextEditingController();
  TextEditingController _TreatmentRemarks = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    final String? id = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[900],
        title: Text(
          "UAT-PQMS",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
              flex: 3,
              child: Container(
                child: Center(
                  child: Text(
                    "Import Treatment Form",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 25,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                    text: "Application Number    ",
                                    style:
                                        TextStyle(color: Colors.green.shade600),
                                    children: [
                                      TextSpan(
                                        text: "$id",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          
                          TextReusable(
                            data: "Duty Officer",
                            controller: _Dutyofficer,
                            requiredData: "*",
                          ),
                          TextReusable(
                            data: "Chemicals",
                            controller: _Chemicals,
                          ),
                          TextReusable(
                            data: "Dosage",
                            controller: _Dosage,
                          ),
                          TextReusable(
                            data: "Duration(Hrs)",
                            controller: _Duration,
                            
                          ),
                          TextReusable(
                            data: "Temperature(DegC)",
                            controller: _Temperature,
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                                readOnly: true,
                                controller: _TreatmentDate,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.green.shade400,
                                  ),
                                  label: RichText(
                                    text: TextSpan(
                                        text: "Treatment Date",
                                        style: TextStyle(
                                            color: Colors.green.shade600),
                                        children: [
                                          TextSpan(
                                            text: "*",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ]),
                                  ),
                                ),
                                onTap: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (selectedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate);
                                    setState(() {
                                      _TreatmentDate.text = formattedDate;
                                    });
                                  }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                                readOnly: true,
                                controller: _CompletedDate,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.green.shade400,
                                  ),
                                  label: RichText(
                                    text: TextSpan(
                                        text:
                                            "Completed Date of Supervision?Treatment",
                                        style: TextStyle(
                                            color: Colors.green.shade600),
                                        children: [
                                          TextSpan(
                                            text: "*",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ]),
                                  ),
                                ),
                                onTap: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (selectedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate);
                                    setState(() {
                                      _CompletedDate.text = formattedDate;
                                    });
                                  }
                                }),
                          ),
                          TextReusable(
                            data: "Done BY",
                            controller: _DoneBy,
                            requiredData: "*",
                          ),
                          TextReusable(
                            maxlines: 5,
                            data: "Treatment Remarks",
                            controller: _TreatmentRemarks,
                            requiredData: "*",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                ),
                child: TextButton(
                  child: Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    final data= ImportTreatmentModelClass(
                      applicationId: id,
                      Dutyofficer: _Dutyofficer.text,
                      Chemicals: _Chemicals.text,
                      Dosage: _Dosage.text,
                      Duration: _Duration.text,
                      Temperature: _Temperature.text,
                      TreatmentDate: _TreatmentDate.text,
                      CompletedDate: _CompletedDate.text,
                      DoneBy: _DoneBy.text,
                      TreatmentRemarks: _TreatmentRemarks.text,
                    );
                    _Dutyofficer.clear();
                    _Chemicals.clear();
                    _Dosage.clear();
                    _Duration.clear();
                    _Temperature.clear();
                    _TreatmentDate.clear();
                    _CompletedDate.clear();
                    _DoneBy.clear();
                    _TreatmentRemarks.clear();
                   
                    final DatabaseHelper _databaseService = DatabaseHelper.instance;

                    final details = await _databaseService.insertInto(data.toJson(),DatabaseHelper.ImportTreatmenttable);
                    print("dbdata:$details");
                    final entries = await _databaseService.queryAllRows(DatabaseHelper.ImportTreatmenttable);
                    print(entries);
                    // final DatabaseHelper _databaseService =
                    //     DatabaseHelper.instance;
                    //  final details=await _databaseService.insertInto(data.toJson(), DatabaseHelper.ImportInspectiontable);
                    //  print("dbdata:$details");
                    //  final Entries = await _databaseService.queryAllRows(DatabaseHelper.ImportInspectiontable);
                    //  print(Entries);
                  },
                ),
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

    _TreatmentDate.text = "";
    _CompletedDate.text="";
  }

}

  
  

