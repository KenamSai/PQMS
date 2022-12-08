import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/import_inspection_response.dart';

import 'package:pqms/reusable/text_reusable_form.dart';

class ImportInspectionSubmit extends StatefulWidget {
  const ImportInspectionSubmit({super.key});

  @override
  State<ImportInspectionSubmit> createState() => _ImportInspectionSubmitState();
}

class _ImportInspectionSubmitState extends State<ImportInspectionSubmit> {
  
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ImportResponseinspectionModelClass;
    TextEditingController _DutyOfficer = TextEditingController(text:args.Dutyofficer);
  TextEditingController _NoOfsamples = TextEditingController(text: args.NoofSamples);
  TextEditingController _Samplesize = TextEditingController(text: args.SampleSize);
  TextEditingController _InspectionPlace = TextEditingController(text: args.InspectionPlace);
  TextEditingController _date = TextEditingController(text: args.InspectionDate);
  TextEditingController _InspectionRemarks =TextEditingController(text: args.InspectionRemarks);
    
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
                    "Import Inspection Entry",
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
                                        // text: "$id",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          TextReusableForm(
                              data: "Duty Officer", controller: _DutyOfficer),
                          TextReusableForm(
                              data: "No of Samples", controller: _NoOfsamples),
                          TextReusableForm(
                              data: "Sample Size", controller: _Samplesize),
                          TextReusableForm(
                              data: "Inspection Place",
                              controller: _InspectionPlace),
                          TextReusableForm(
                              data: "Completed Inspection Date",
                              controller: _date),
                          TextReusableForm(
                              data: "Inspection Remarks",
                              controller: _InspectionRemarks),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
