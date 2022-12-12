import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/import_inspection_response.dart';
import 'package:pqms/ModelClass/import_inspection_submit.dart';
import 'package:pqms/ModelClass/import_inspection_submit_response.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/reusable/text_reusable_form.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class ImportInspectionSubmit extends StatefulWidget {
  const ImportInspectionSubmit({super.key});

  @override
  State<ImportInspectionSubmit> createState() => _ImportInspectionSubmitState();
}

class _ImportInspectionSubmitState extends State<ImportInspectionSubmit> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ImportResponseinspectionModelClass;
    TextEditingController _DutyOfficer =
        TextEditingController(text: args.Dutyofficer);
    TextEditingController _NoOfsamples =
        TextEditingController(text: args.NoofSamples);
    TextEditingController _Samplesize =
        TextEditingController(text: args.SampleSize);
    TextEditingController _InspectionPlace =
        TextEditingController(text: args.InspectionPlace);
    TextEditingController _date =
        TextEditingController(text: args.InspectionDate);
    TextEditingController _InspectionRemarks =
        TextEditingController(text: args.InspectionRemarks);

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
                                        text: "${args.applicationId}",
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
                                args.userimage1 == ""
                                    ? Icon(
                                        Icons.camera_enhance,
                                        size: 50,
                                      )
                                    : Image.file(
                                        width: 100,
                                        height: 100,
                                        File(
                                          args.userimage1 ?? "",
                                        ),
                                      ),
                                args.userimage2 == ""
                                    ? Icon(
                                        Icons.camera_enhance,
                                        size: 50,
                                      )
                                    : Image.file(
                                        width: 100,
                                        height: 100,
                                        File(args.userimage2 ?? ""),
                                      ),
                                args.userimage3 == ""
                                    ? Icon(
                                        Icons.camera_enhance,
                                        size: 50,
                                      )
                                    : Image.file(
                                        width: 100,
                                        height: 100,
                                        File(args.userimage3 ?? ""),
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
                    submitDetails(args);
                    // args.applicationId = "";
                    // args.Dutyofficer='';
                    // args.NoofSamples='';
                    // args.SampleSize='';
                    // args.InspectionPlace='';
                    // args.InspectionDate='';
                    // args.InspectionRemarks='';
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitDetails(ImportResponseinspectionModelClass args) async {

    final requestUrl = BaseUrl.uat_base_url + EndPoints.importinspectionsubmit;
    final importinspectionSubmit = ImportInspectionSubmitModel();
    importinspectionSubmit.inspectionPlace = args.InspectionPlace;
    importinspectionSubmit.noOfSamples = args.NoofSamples;
    importinspectionSubmit.action = "";
    importinspectionSubmit.applicationId = "";
    importinspectionSubmit.role = "Inspector";
    importinspectionSubmit.remarks = args.InspectionRemarks;
    importinspectionSubmit.employeeId = "";
    importinspectionSubmit.forwardToRole = "";
    importinspectionSubmit.inspectionDate = args.InspectionDate;
    importinspectionSubmit.sampleSize = args.SampleSize;
    importinspectionSubmit.inptLocation = "";
    importinspectionSubmit.deviceId = "7b1fe3550ff840b2";
    importinspectionSubmit.inspctArea = "";
    importinspectionSubmit.inptDoc1 = args.userimage1;
    importinspectionSubmit.inptDoc2 = args.userimage2;
    importinspectionSubmit.inptDoc3 = args.userimage3;
    importinspectionSubmit.toJson();
     print(importinspectionSubmit.toJson());

    final requestPayload = importinspectionSubmit.toJson();
    final token =
        await SharedPreferencesClass().readTheData(PreferenceConst.token);
    final username =
        await SharedPreferencesClass().readTheData(PreferenceConst.username);
    Map<String, String> requestHeaders = {
      'clientId': 'Client123Cgg',
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*',
      "token": token.toString(),
      "userName": username.toString(),
    };
    final _dioObject = Dio();

    try {
      final _response = await _dioObject.post(requestUrl,
          data: requestPayload, options: Options(headers: requestHeaders));
      //converting response from json to model cls
      final importinspectionSubmitresponse = ImportInspectionSubmitResponse.fromJson(_response.data);
        print(_response.data);
      
      if (importinspectionSubmitresponse.statusCode == 200) {
        print("Data Submitted");
        }
        else if (importinspectionSubmitresponse.statusCode == 204)
        {
            print("NOt submitted");
        }
        
       
    
    } on DioError catch (e) {
     
      if (e.response?.statusCode == 400 || e.response?.statusCode == 500) {
        print(e.message);
        //Alert
      }
    }
  }
}
