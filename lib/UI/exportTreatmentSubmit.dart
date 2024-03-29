import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/exporttreatmentresponsemodel.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/reusable/TextReusable.dart';
import 'package:pqms/reusable/alertWithButtonDone.dart';
import 'package:pqms/reusable/alert_dailog.dart';
import 'package:pqms/reusable/alert_singlebutton.dart';
import 'package:pqms/reusable/alert_withtwo_buttons.dart';
import 'package:pqms/reusable/reusableAlert.dart';
import 'package:pqms/reusable/singlebutton_alert.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class ExportTreatmentSubmit extends StatefulWidget {
  const ExportTreatmentSubmit({super.key});

  @override
  State<ExportTreatmentSubmit> createState() => ExportTreatmentSubmitState();
}

class ExportTreatmentSubmitState extends State<ExportTreatmentSubmit> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments
        as exporttreatmentresponsemodelclass;
    //print(id.applicationId);
    TextEditingController _DutyOfficer =
        TextEditingController(text: id.dutyofficer);
    TextEditingController _Chemicals =
        TextEditingController(text: id.chemicals);
    TextEditingController _Dosage = TextEditingController(text: id.dosage);
    TextEditingController _Duration =
        TextEditingController(text: id.durationHrs);
    TextEditingController _Temperature =
        TextEditingController(text: id.temperatureDegC);
    TextEditingController _TreatmentDate =
        TextEditingController(text: id.treatmentDate);
    TextEditingController _CompletedDate =
        TextEditingController(text: id.completionDate);
    TextEditingController _DoneBy = TextEditingController(text: id.doneby);
    TextEditingController _TreatmentRemarks =
        TextEditingController(text: id.treatmentRemarks);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: customColors.colorPQMS,
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
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialogBoxTwoButtons(
                          title: "UAT-PQMS",
                          descriptions: "Do you want to submit?",
                          Buttontext1: "No ",
                          Buttontext2: "Yes",
                          img: Image.asset("assets/warning.png"),
                          onButton1Pressed: () {
                            Navigator.pop(context);
                          },
                          onButton2Pressed: () async {
                            var result =
                                await Connectivity().checkConnectivity();

                            if (result == ConnectivityResult.mobile ||
                                result == ConnectivityResult.wifi) {
                              final requestUrl = BaseUrl.finalURL +
                                  EndPoints.saveExportPermitAction;
                              final requestPayLoad = {
                                "role": "Inspector",
                                "action": "Forward",
                                "applicationId": id.applicationId,
                                "chemicals": id.chemicals,
                                "dosage": id.dosage,
                                "duration": id.durationHrs,
                                "temperature": id.temperatureDegC,
                                "treatmentDate": id.treatmentDate,
                                "completedDateofSupervision": id.completionDate,
                                "doneByAgency": id.agencyId,
                                "remarks": id.treatmentRemarks,
                                "employeeId": id.dutyofficerId,
                                "forwardToRole": "Duty officer"
                              };
                              print("payLoad:  $requestPayLoad");
                              final String token =
                                  await SharedPreferencesClass().readTheData(
                                PreferenceConst.token,
                              );
                              final String username =
                                  await SharedPreferencesClass().readTheData(
                                PreferenceConst.username,
                              );
                              print(token);
                              print(username);
                              final requestHeaders = {
                                "clientId": "Client123Cgg",
                                "token": token.toString(),
                                "userName": username.toString()
                              };
                              final _dioObject = Dio();
                              try {
                                final Response = await _dioObject.post(
                                  requestUrl,
                                  data: requestPayLoad,
                                  options: Options(headers: requestHeaders),
                                );
                                if (Response.data["status_Code"] == 200) {
                                  final value = await DatabaseHelper.instance
                                      .deleteTheRequired(
                                          id.applicationId ?? "",
                                          DatabaseHelper.exporttreatmenttable,
                                          "applicationId");
                                  print("Treatment count:$value");
                                  Navigator.pop(context);
                                  showAlert(Response.data["status_Message"]);
                                }
                              } on DioError catch (e) {
                                print("error");
                              }
                            } else {
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
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                ModalRoute.withName(AppRoutes.exportsaved),
              );
            });
      },
    );
  }
}
