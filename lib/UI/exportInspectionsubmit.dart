import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/exportInspectionResponseModelClass.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/TextReusable.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

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
    String image1 = "";
    String image2 = "";
    String image3 = "";

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
                context,
                ModalRoute.withName(AppRoutes.exportinspection),
              );
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
                    final deviceId = await _getId();
                    //print("id:  $deviceId");
                    if (id.userimage1!.isNotEmpty) {
                      final bytes1 = File("${id.userimage1}").readAsBytesSync();
                      image1 = base64Encode(bytes1);
                    }
                    if (id.userimage2!.isNotEmpty) {
                      final bytes2 = File("${id.userimage2}").readAsBytesSync();
                      image2 = base64Encode(bytes2);
                    }
                    if (id.userimage3!.isNotEmpty) {
                      final bytes3 = File("${id.userimage3}").readAsBytesSync();
                      image3 = base64Encode(bytes3);
                    }

                    final requestUrl =
                        "https://pqms-uat.cgg.gov.in/pqms/saveExportPermitAction";
                    final requestPayLoad = {
                      "role": "Inspector",
                      "applicationId": id.applicationId,
                      "noOfSamples": id.noofSamples,
                      "sampleSize": id.sampleSize,
                      "inspectionPlace": id.inspectionPlace,
                      "inspectionDate": id.inspectionDate,
                      "remarks": id.inspectionRemarks,
                      "action": "forward",
                      "employeeId": id.dutyofficerId, //pass id not name
                      "forwardToRole": "Duty officer",
                      "inptLocation": "17.436858,78.361197",
                      "deviceId": deviceId,
                      "inspctArea": "",
                      "inptDoc1":
                          id.userimage1!.isNotEmpty ? image1 : id.userimage1,
                      "inptDoc2":
                          id.userimage2!.isNotEmpty ? image2 : id.userimage2,
                      "inptDoc3":
                          id.userimage3!.isNotEmpty ? image3 : id.userimage3
                    };
                    final token = await SharedPreferencesClass()
                        .readTheData(PreferenceConst.token);
                    final username = await SharedPreferencesClass()
                        .readTheData(PreferenceConst.username);
                    final requestHeaders = {
                      "clientId": "Client123Cgg",
                      "token": token.toString(),
                      "userName": username.toString(),
                    };
                    final _dioObject = Dio();
                    try {
                      final _response = await _dioObject.post(
                        requestUrl,
                        data: requestPayLoad,
                        options: Options(headers: requestHeaders),
                      );
                      if (_response.data["status_Code"] == 200) {
                       final value= await DatabaseHelper.instance.deleteTheRequired(
                            id.applicationId ?? "",
                            DatabaseHelper.ExportInspectiontable,
                            "applicationId");
                            print("count:$value");
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Message",
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                              icon: Icon(
                                Icons.done_all_outlined,
                                color: Colors.green,
                                size: 50,
                              ),
                              content: Text(
                                "${_response.data["status_Message"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          AppRoutes.exportinspectionsaved),
                                    );
                                  },
                                  child: Text(
                                    "OK",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      }
                    } on DioError catch (e) {
                      print("error");
                    }
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
  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }
}
