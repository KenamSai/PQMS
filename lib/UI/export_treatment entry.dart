import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pqms/ModelClass/exporttreatmentresponsemodel.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/TextReusable.dart';

class ExportTreatmentForm extends StatefulWidget {
  const ExportTreatmentForm({super.key});

  @override
  State<ExportTreatmentForm> createState() => _ExportTreatmentForm();
}

class _ExportTreatmentForm extends State<ExportTreatmentForm> {
  TextEditingController _DutyOfficer = TextEditingController();
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
    final String id = ModalRoute.of(context)?.settings.arguments as String;
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
                    "Export Treatment Form",
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
                          //Text("Application Number  :$id"),
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
                            controller: _DutyOfficer,
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
                                            """Completed Date of Supervision/Treatment""",
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
                            data: "Done By",
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
                  onPressed: ()async {
                    // print("id$id");
                    // print("date${_CompletedDate.text}");
                    final Response = exporttreatmentresponsemodelclass(
                        applicationId: id.toString(),
                        chemicals: _Chemicals.text,
                        completionDate: _CompletedDate.text,
                        treatmentDate: _TreatmentDate.text,
                        doneby: _DoneBy.text,
                        dosage: _Dosage.text,
                        durationHrs: _Duration.text,
                        dutyofficer: _DutyOfficer.text,
                        temperatureDegC: _Temperature.text,
                        treatmentRemarks: _TreatmentRemarks.text);

                        print(Response.applicationId);
                         print(Response.chemicals);
                          print(Response.completionDate);
                           print(Response.treatmentDate);
                            print(Response.doneby);
                             print(Response.dosage);
                              print(Response.durationHrs);
                              print(Response.dutyofficer);
                               print(Response.temperatureDegC);
                                print(Response.treatmentRemarks);
                    _Chemicals.clear();
                    _CompletedDate.clear();
                    _TreatmentDate.clear();
                    _DoneBy.clear();
                    _Dosage.clear();
                    _Duration.clear();
                    _DutyOfficer.clear();
                    _Temperature.clear();
                    _TreatmentRemarks.clear();
                    final DatabaseHelper _databaseService =
                        DatabaseHelper.instance;
                        final DBdetails=await _databaseService.insertInto(Response.toJson(), "ExportTreatment");
                        print("teja: $DBdetails");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
