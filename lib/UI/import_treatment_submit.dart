import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/import_treatment_response.dart';
import 'package:pqms/reusable/TextReusable.dart';

class ImportTreatmentSubmit extends StatefulWidget {
  const ImportTreatmentSubmit({super.key});

  @override
  State<ImportTreatmentSubmit> createState() => _ImportTreatmentSubmit();
}

class _ImportTreatmentSubmit extends State<ImportTreatmentSubmit> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as ImportTreatmentModelClass;
    //print(id.applicationId);
    TextEditingController _DutyOfficer =
        TextEditingController(text: args.Dutyofficer);
    TextEditingController _Chemicals =
        TextEditingController(text: args.Chemicals);
    TextEditingController _Dosage = TextEditingController(text: args.Dosage);
    TextEditingController _Duration =
        TextEditingController(text: args.Duration);
    TextEditingController _Temperature =
        TextEditingController(text: args.Temperature);
    TextEditingController _TreatmentDate =
        TextEditingController(text: args.TreatmentDate);
    TextEditingController _CompletedDate =
        TextEditingController(text: args.CompletedDate);
    TextEditingController _DoneBy = TextEditingController(text: args.DoneBy);
    TextEditingController _TreatmentRemarks =
        TextEditingController(text: args.TreatmentRemarks);

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
                                        text: "${args.applicationId}",
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
                            readType: true,
                          ),
                          TextReusable(
                            data: "Chemicals",
                            controller: _Chemicals,
                            readType: true,
                          ),
                          TextReusable(
                            data: "Dosage",
                            controller: _Dosage,
                            readType: true,
                          ),
                          TextReusable(
                            data: "Duration(Hrs)",
                            controller: _Duration,
                            readType: true,
                          ),
                          TextReusable(
                            data: "Temperature(DegC)",
                            controller: _Temperature,
                            readType: true,
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
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green.shade400),
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
                            ),
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
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green.shade400),
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
                            ),
                          ),
                          TextReusable(
                            data: "Done By",
                            readType: true,
                            controller: _DoneBy,
                            requiredData: "*",
                          ),
                          TextReusable(
                            readType: true,
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
                    "SUBMIT",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    setState(() {
                      args.applicationId = "";
                      args.Dutyofficer="";
                      args.Chemicals='';
                      args.Dosage='';
                      args.Duration='';
                      args.Temperature='';
                      args.TreatmentDate='';
                      args.CompletedDate='';
                      args.DoneBy='';
                      args.TreatmentRemarks='';
                     
                    });
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
