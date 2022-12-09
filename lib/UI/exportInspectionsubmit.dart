import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pqms/ModelClass/exportInspectionResponseModelClass.dart';
import 'package:pqms/reusable/TextReusable.dart';
import 'package:pqms/routes/AppRoutes.dart';

class exportInspectionSubmission extends StatefulWidget {
  const exportInspectionSubmission({super.key});

  @override
  State<exportInspectionSubmission> createState() =>
      _exportInspectionSubmissionState();
}

class _exportInspectionSubmissionState
    extends State<exportInspectionSubmission> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments
        as exportResponseinspectionModelClass;
    TextEditingController _DutyOfficer = TextEditingController(
      text: id.dutyofficer,
    );
    TextEditingController _NoOfSamples = TextEditingController(
      text: id.noofSamples,
    );
    TextEditingController _SampleSize = TextEditingController(
      text: id.sampleSize,
    );
    TextEditingController _InspectionPlace = TextEditingController(
      text: id.inspectionPlace,
    );
    TextEditingController _CompletedDate = TextEditingController(
      text: id.inspectionDate,
    );
    TextEditingController _Remarks = TextEditingController(
      text: id.inspectionRemarks,
    );
    // TextEditingController _userimage1 = TextEditingController(
    //   text: id.userimage1,
    // );
    // TextEditingController _userimage2 = TextEditingController(
    //   text: id.userimage2,
    // );
    // TextEditingController _userimage3 = TextEditingController(
    //   text: id.userimage3,
    // );

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
              Navigator.popUntil(
                  context, ModalRoute.withName(AppRoutes.dashboardpage));
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
                    "Export Inspection Form",
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
                                        text: "${id.applicationId}",
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
                            data: "No Of Samples",
                            controller: _NoOfSamples,
                            readType: true,
                          ),
                          TextReusable(
                            data: "Sample Size",
                            controller: _SampleSize,
                            readType: true,
                          ),
                          TextReusable(
                            data: "Inspection PLace",
                            controller: _InspectionPlace,
                            readType: true,
                            requiredData: "*",
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
                                      text: "Completed Inspection Date",
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
                            data: "Inspection Remarks",
                            readType: true,
                            controller: _Remarks,
                            requiredData: "*",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: RichText(
                              text: TextSpan(
                                  text: "Capture Image",
                                  style:
                                      TextStyle(color: Colors.green.shade600),
                                  children: [
                                    TextSpan(
                                      text: "*",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                id.userimage1 == ""
                                    ? Icon(
                                        Icons.camera_enhance,
                                        size: 50,
                                      )
                                    : Image.file(
                                        width: 100,
                                        height: 100,
                                        File(
                                          id.userimage1 ?? "",
                                        ),
                                      ),
                                id.userimage2 == ""
                                    ? Icon(
                                        Icons.camera_enhance,
                                        size: 50,
                                      )
                                    : Image.file(
                                        width: 100,
                                        height: 100,
                                        File(id.userimage2 ?? ""),
                                      ),
                                id.userimage3 == ""
                                    ? Icon(
                                        Icons.camera_enhance,
                                        size: 50,
                                      )
                                    : Image.file(
                                        width: 100,
                                        height: 100,
                                        File(id.userimage3 ?? ""),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
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
                      // id.applicationId = "";
                      // id.chemicals='';
                      // id.completionDate='';
                      // id.treatmentDate='';
                      // id.doneby='';
                      // id.dosage='';
                      // id.dutyofficer='';
                      // id.temperatureDegC='';
                      // id.treatmentRemarks='';
                      // id.durationHrs='';
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
