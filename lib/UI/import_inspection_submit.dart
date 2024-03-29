import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/import_inspection_response.dart';
import 'package:pqms/ModelClass/import_inspection_submit.dart';
import 'package:pqms/ModelClass/import_inspection_submit_response.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/alertWithButtonDone.dart';
import 'package:pqms/reusable/alert_dailog.dart';
import 'package:pqms/reusable/alert_singlebutton.dart';
import 'package:pqms/reusable/alert_withtwo_buttons.dart';
import 'package:pqms/reusable/deviceID.dart';
import 'package:pqms/reusable/singlebutton_alert.dart';
import 'package:pqms/reusable/text_reusable_form.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class ImportInspectionSubmit extends StatefulWidget {
  const ImportInspectionSubmit({super.key});

  @override
  State<ImportInspectionSubmit> createState() => _ImportInspectionSubmitState();
}

class _ImportInspectionSubmitState extends State<ImportInspectionSubmit> {
  String imagePreview1 = "";
  String imagePreview2 = "";
  String imagePreview3 = "";
  String img1 = "";
  String img2 = "";
  String img3 = "";

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
    TextEditingController _QuantityFound =
        TextEditingController(text: args.QuantityFound);

    imagePreview1 = args.userimage1!;
    imagePreview2 = args.userimage2!;
    imagePreview3 = args.userimage3!;
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
              size: 30,
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
                          TextReusableForm(
                              data: "Quantity Found",
                              controller: _QuantityFound),
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

                                          //image=args.userimage1;
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
                    showDialog(
                        context: context,
                        builder: ((context) => CustomDialogBoxTwoButtons(
                            title: "UAT-PQMS",
                            descriptions: "Do You Want To Submit?",
                            Buttontext1: "No",
                            Buttontext2: "Yes",
                            img: Image.asset("assets/warning.png"),
                            onButton1Pressed: (() {
                              Navigator.pop(context);
                            }),
                            onButton2Pressed: (() async {
                              Navigator.pop(context);
                              var result =await Connectivity().checkConnectivity();
                              if (result == ConnectivityResult.mobile ||
                                  result == ConnectivityResult.wifi) 
                                  {
                                     submitDetails(args);
                                  } 
                              else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SingleButtonDialogBox(
                                        title: "UAT-PQMS",
                                        descriptions:
                                            "Please Check your Internet Connectivity",
                                        Buttontext: "Ok",
                                        img: Image.asset("assets/caution.png"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        });
                                  },
                                );
                              }

                              
                            }))));

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
    final requestUrl = BaseUrl.finalURL + EndPoints.importinspectionsubmit;
    print("preview" + imagePreview1);
    // Image.file(new File(imagePreview!));
    if (imagePreview1 != "") {
      final bytes1 = File(imagePreview1).readAsBytesSync();
      img1 = base64Encode(bytes1);
    }
    if (imagePreview2 != "") {
      final bytes2 = File(imagePreview2).readAsBytesSync();
      img2 = base64Encode(bytes2);
    }
    if (imagePreview3 != "") {
      final bytes3 = File(imagePreview3).readAsBytesSync();
      img3 = base64Encode(bytes3);
    }

    //print("img64"+img64);
    final importinspectionSubmit = ImportInspectionSubmitModel();

    importinspectionSubmit.quantityfound = args.QuantityFound.toString();
    importinspectionSubmit.inspectionPlace = args.InspectionPlace.toString();
    importinspectionSubmit.noOfSamples = args.NoofSamples.toString();
    importinspectionSubmit.action = "Forward";
    importinspectionSubmit.applicationId = args.applicationId.toString();
    importinspectionSubmit.role = "Inspector";
    importinspectionSubmit.remarks = args.InspectionRemarks.toString();
    importinspectionSubmit.employeeId = args.DutyOfficerId.toString();
    importinspectionSubmit.forwardToRole = "Duty officer";
    importinspectionSubmit.inspectionDate = args.InspectionDate.toString();
    importinspectionSubmit.sampleSize = args.SampleSize.toString();
    importinspectionSubmit.inptLocation =
        args.inptLocation.toString(); //get latlang
    importinspectionSubmit.deviceId = await Utils().getDeviceId();
    importinspectionSubmit.inspctArea = args.inspctArea;
    importinspectionSubmit.inptDoc1 = imagePreview1.isNotEmpty ? img1 : " ";
    importinspectionSubmit.inptDoc2 = imagePreview2.isNotEmpty ? img2 : " ";
    importinspectionSubmit.inptDoc3 = imagePreview3.isNotEmpty ? img3 : " ";

    importinspectionSubmit.toJson();
    print(importinspectionSubmit.toJson());
    print(args.userimage1);
    print(args.inptLocation);
    print(args.inspctArea);
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
      final importinspectionSubmitresponse =
          ImportInspectionSubmitResponse.fromJson(_response.data);
      print(_response.data);

      if (importinspectionSubmitresponse.statusCode == 200) {
        DatabaseHelper.instance.ImportInspectiondelete(
            args.applicationId!, DatabaseHelper.ImportInspectiontable);
        showAlert(_response.data["status_Message"].toString());
        print("Data Submitted");
      } else if (importinspectionSubmitresponse.statusCode == 204) {
        print("NOt submitted");
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 500) {
        print(e.message);
        //Alert
      }
    }
  }

  showAlert(msg) {
    showDialog(
      context: context,
      builder: (context) {
        return alertWithButton(
            title: "UAT-PQMS",
            descriptions: msg,
            Buttontext: "Ok",
            img: Image.asset("assets/correct.png"),
            onButtonPressed: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName(AppRoutes.importsaved),
              );
            });
      },
    );
  }
}
