

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pqms/ModelClass/exportInspectionResponseModelClass.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/TextReusable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pqms/reusable/imagecallback.dart';

class ExportInspectionEntry extends StatefulWidget {
  const ExportInspectionEntry({super.key});

  @override
  State<ExportInspectionEntry> createState() => _ExportInspectionEntryState();
}

class _ExportInspectionEntryState extends State<ExportInspectionEntry> {
  TextEditingController _DutyOfficer = TextEditingController();
  TextEditingController _NoOfsamples = TextEditingController();
  TextEditingController _Samplesize = TextEditingController();
  TextEditingController _InspectionPlace = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _InspectionRemarks = TextEditingController();

  @override
  Widget build(BuildContext context) {
    XFile imageData1 = XFile("");
    XFile imageData2 = XFile("");
    XFile imageData3 = XFile("");

    String id = ModalRoute.of(context)?.settings.arguments as String;
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
                    "Export Inspection Entry",
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
                            controller: _DutyOfficer,
                            requiredData: "*",
                          ),
                          TextReusable(
                            data: "No Samples",
                            controller: _NoOfsamples,
                          ),
                          TextReusable(
                            data: "Sample size",
                            controller: _Samplesize,
                          ),
                          TextReusable(
                            data: "Inspection Place",
                            controller: _InspectionPlace,
                            requiredData: "*",
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: TextField(
                                readOnly: true,
                                controller: _date,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green.shade700),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.green.shade400,
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
                                onTap: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                  );
                                  if (selectedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate);
                                    setState(() {
                                      _date.text = formattedDate;
                                    });
                                  }
                                }),
                          ),
                          TextReusable(
                            data: "Inspection Remarks",
                            controller: _InspectionRemarks,
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
                                ImgPickerCamera(
                                  callbackValue: (imageData) {
                                    imageData1 = imageData;
                                    // print("path1:${imageData1.path}");
                                  },
                                ),
                                ImgPickerCamera(
                                  callbackValue: (imageData) {
                                    imageData2 = imageData;
                                    //print("path2:${imageData2.path}");
                                  },
                                ),
                                ImgPickerCamera(
                                  callbackValue: (imageData) {
                                    imageData3 = imageData;
                                    //print("path3:${imageData3.path}");
                                  },
                                ),
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
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: ()async {
                    final data = exportResponseinspectionModelClass(
                      applicationId: id,
                      dutyofficer: _DutyOfficer.text,
                      noofSamples: _NoOfsamples.text,
                      inspectionDate: _date.text,
                      sampleSize: _Samplesize.text,
                      inspectionPlace: _InspectionPlace.text,
                      inspectionRemarks: _InspectionRemarks.text,
                      userimage1: imageData1.path,
                      userimage2: imageData2.path,
                      userimage3: imageData3.path,
                    );
                    _DutyOfficer.clear();
                    _NoOfsamples.clear();
                    _Samplesize.clear();
                    _InspectionPlace.clear();
                    _date.clear();
                    _InspectionRemarks.clear();
                  
                   

                    final DatabaseHelper _databaseService =
                        DatabaseHelper.instance;
                     final details=await _databaseService.insertInto(data.toJson(), DatabaseHelper.ExportInspectiontable);
                     print("dbdata:$details");
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

    _date.text = "";
  }
}
