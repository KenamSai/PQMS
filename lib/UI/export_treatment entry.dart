import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:pqms/ModelClass/DonebyModelClass.dart';
import 'package:pqms/ModelClass/DonebyModelResponseTreatment.dart';
import 'package:pqms/ModelClass/DutyOfficersResponse.dart';
import 'package:pqms/ModelClass/exporttreatmentresponsemodel.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/reusable/TextReusable.dart';
import 'package:pqms/reusable/alertWithButtonDone.dart';
import 'package:pqms/reusable/alert_singlebutton.dart';
import 'package:pqms/reusable/alert_withtwo_buttons.dart';
import 'package:pqms/reusable/singlebutton_alert.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

import '../ModelClass/DutyOfficers.dart';

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
  List<Data> DutyOfficersList = [];
  int? DutyOfficerId;
  String? selectedValue;
  List<DataAgencyList> AgencyList = [];
  List<DonebyModelResponseTreatment> AgencyNameID = [];
  String? selectedAgencyName;
  int? AgencyId;

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)?.settings.arguments as String;
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
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: RichText(
                                    text: TextSpan(
                                      text: "DutyOfficer",
                                      style: TextStyle(color: Colors.green),
                                      children: [
                                        TextSpan(
                                          text: " *",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: DropdownButton<String>(
                                    value: selectedValue != ""
                                        ? selectedValue
                                        : "",
                                    underline: Container(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    isExpanded: true,
                                    onChanged: (changedValue) {
                                      setState(
                                        () {
                                          selectedValue = changedValue;
                                          if (selectedValue != "") {
                                            DutyOfficersList.forEach(
                                              (element) {
                                                if (selectedValue ==
                                                    element.name) {
                                                  DutyOfficerId = element.id;
                                                }
                                              },
                                            );
                                          }
                                        },
                                      );
                                    },
                                    items: DutyOfficersList.map(
                                      (DutyOfficerName) {
                                        return new DropdownMenuItem<String>(
                                          value: DutyOfficerName.name,
                                          child:
                                              Text(DutyOfficerName.name ?? ""),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    onPressed: (() async {
                                      DutyOfficersList.forEach((element) async {
                                        final count = await DatabaseHelper
                                            .instance
                                            .delete(element.id ?? 0,
                                                DatabaseHelper.DutyOfficers);
                                        print("deletion Count in db:$count");
                                      });
                                      setState(() {
                                        DutyOfficersList.clear();
                                        //selectedValue="";
                                      });
                                      var result = await Connectivity()
                                          .checkConnectivity();

                                      if (result == ConnectivityResult.mobile ||
                                          result == ConnectivityResult.wifi) {
                                        getDutyOffcersList();
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SingleButtonDialogBox(
                                                title: "UAT-PQMS",
                                                descriptions:
                                                    "Please Check your Internet Connectivity",
                                                Buttontext: "Ok",
                                                img: Image.asset(
                                                    "assets/caution.png"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                });
                                          },
                                        );
                                      }
                                    }),
                                    icon: Icon(
                                      Icons.repeat_outlined,
                                      color: customColors.colorPQMS,
                                    ),
                                  ),
                                )
                              ],
                            ),
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
                            keyboardtype: TextInputType.number,
                            format: [
                              FilteringTextInputFormatter.allow(
                                RegExp(
                                  r"[0-9.]",
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
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
                            padding: const EdgeInsets.all(6.0),
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
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Doneby",
                                      style: TextStyle(color: Colors.green),
                                      children: [
                                        TextSpan(
                                          text: " *",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: DropdownButton<String>(
                                    value: selectedAgencyName != ""
                                        ? selectedAgencyName
                                        : "",
                                    underline: Container(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    isExpanded: true,
                                    onChanged: (changedValue) {
                                      setState(() {
                                        selectedAgencyName = changedValue;
                                        if (selectedAgencyName != "") {
                                          AgencyNameID.forEach((element) {
                                            if (selectedAgencyName ==
                                                element.fumigationAgent) {
                                              AgencyId = element.id;
                                              //print("AgencyId:  $AgencyId");
                                            }
                                          });
                                        }
                                      });
                                    },
                                    items: AgencyNameID.map((AgencyName) {
                                      return new DropdownMenuItem<String>(
                                        value: AgencyName.fumigationAgent,
                                        child: Text(
                                            AgencyName.fumigationAgent ?? ""),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextReusable(
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
                    if (selectedValue == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogBox(
                              title: "UAT-PQMS",
                              descriptions: "Please Select DutyOfficer",
                              Buttontext: "ok",
                              img: Image.asset("assets/caution.png"),
                              onPressed: (() {
                                Navigator.pop(context);
                              }));
                        },
                      );
                    } else if (_TreatmentDate.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogBox(
                              title: "UAT-PQMS",
                              descriptions: "Please Enter Treatment Date",
                              Buttontext: "ok",
                              img: Image.asset("assets/caution.png"),
                              onPressed: (() {
                                Navigator.pop(context);
                              }));
                        },
                      );
                    } else if (_CompletedDate.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogBox(
                              title: "UAT-PQMS",
                              descriptions:
                                  "Please Select Completed Date of  Supervision/Treatment",
                              Buttontext: "ok",
                              img: Image.asset("assets/caution.png"),
                              onPressed: (() {
                                Navigator.pop(context);
                              }));
                        },
                      );
                    } else if (selectedAgencyName == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogBox(
                              title: "UAT-PQMS",
                              descriptions: "Please Select Agency List",
                              Buttontext: "ok",
                              img: Image.asset("assets/caution.png"),
                              onPressed: (() {
                                Navigator.pop(context);
                              }));
                        },
                      );
                    } else if (_TreatmentRemarks.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogBox(
                              title: "UAT-PQMS",
                              descriptions: "Please Enter Treatment Remarks",
                              Buttontext: "ok",
                              img: Image.asset("assets/caution.png"),
                              onPressed: (() {
                                Navigator.pop(context);
                              }));
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialogBoxTwoButtons(
                              title: "UAT-PQMS",
                              descriptions: "Do you want to save data locally?",
                              Buttontext1: "No",
                              Buttontext2: "Yes",
                              img: Image.asset("assets/warning.png"),
                              onButton1Pressed: () {
                                Navigator.pop(context);
                              },
                              onButton2Pressed: () async {
                                final Response =
                                    exporttreatmentresponsemodelclass(
                                  applicationId: id.toString(),
                                  chemicals: _Chemicals.text,
                                  completionDate: _CompletedDate.text,
                                  treatmentDate: _TreatmentDate.text,
                                  dutyofficerId: DutyOfficerId,
                                  dosage: _Dosage.text,
                                  durationHrs: _Duration.text,
                                  dutyofficer: selectedValue,
                                  temperatureDegC: _Temperature.text,
                                  treatmentRemarks: _TreatmentRemarks.text,
                                  doneby: selectedAgencyName,
                                  agencyId: AgencyId,
                                );
                                final DatabaseHelper _databaseService =
                                    DatabaseHelper.instance;
                                final DBdetails =
                                    await _databaseService.insertInto(
                                        Response.toJson(), "ExportTreatment");
                                print("teja: $DBdetails");
                                Navigator.pop(context);
                                showAlert();
                              });
                        },
                      );
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

  void initState() {
    dbRetrieve().then((value) async {
      //print(DutyOfficersList.length);
      if (DutyOfficersList.isEmpty) {
        var result = await Connectivity().checkConnectivity();

        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          getDutyOffcersList();
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  title: "UAT-PQMS",
                  descriptions: "Please Check your Internet Connectivity",
                  Buttontext: "Ok",
                  img: Image.asset("assets/caution.png"),
                  onPressed: () {
                    Navigator.pop(context);
                  });
            },
          );
        }
      }
    });
    dbRetrieveAgencyList().then((value) async {
      //print("agent length: ${AgencyNameID.length}");
      if (AgencyNameID.isEmpty) {
        var result = await Connectivity().checkConnectivity();

        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          getAgencyList();
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  title: "UAT-PQMS",
                  descriptions: "Please Check your Internet Connectivity",
                  Buttontext: "Ok",
                  img: Image.asset("assets/caution.png"),
                  onPressed: () {
                    Navigator.pop(context);
                  });
            },
          );
        }
      }
    });
  }

  getDutyOffcersList() async {
    EasyLoading.show(status: "Loading...", maskType: EasyLoadingMaskType.black);
    String requestUrl = BaseUrl.finalURL + EndPoints.getEmployeeListByRole;
    final requestPayLoad = {
      "actionType": "Duty officer",
      "appLevel": 1,
      "formType": 3,
      "forwoardToRoleName": "Duty officer"
    };
    final token =
        await SharedPreferencesClass().readTheData(PreferenceConst.token);
    final username =
        await SharedPreferencesClass().readTheData(PreferenceConst.username);
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
      final dataResponse = employDetails.fromJson(_response.data);
      if (dataResponse.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          new SnackBar(
            content: Text("DutyOfficers List Updated!"),
          ),
        );
      }
      setState(() {
        DutyOfficersList = dataResponse.data!;
      });
      final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
      DutyOfficersList.forEach((element) async {
        final Response = DutyOfficersResponse(
          name: element.name,
          userId: element.id,
        );
        final DbCOunt = await _databaseHelper.insertInto(
            Response.toJson(), DatabaseHelper.DutyOfficers);
        print("count=$DbCOunt");
      });
      setState(() {
        DutyOfficersList.clear();
        print("count:${DutyOfficersList.length}");
      });
      dbRetrieve();
    } on DioError catch (e) {
      print("error");
    }
  }

  dbRetrieve() async {
    await DatabaseHelper.instance
        .queryAllRows(DatabaseHelper.DutyOfficers)
        .then((value) {
      setState(() {
        value.forEach((element) {
          DutyOfficersList.add(
            Data(
              id: element["UserId"],
              name: element["Name"],
            ),
          );
        });
      });
    }).catchError((error) {
      print(error);
    });
  }

  dbRetrieveAgencyList() async {
    await DatabaseHelper.instance
        .queryAllRows(DatabaseHelper.AgencyList)
        .then((value) {
      setState(() {
        value.forEach((element) {
          AgencyNameID.add(
            DonebyModelResponseTreatment(
              fumigationAgent: element["fumigationAgent"],
              id: element["id"],
            ),
          );
        });
      });
    }).catchError((error) {
      print(error);
    });
    EasyLoading.dismiss();
  }

  getAgencyList() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black, status: "Loading...");
    String requestUrl = BaseUrl.finalURL + EndPoints.agenciesList;
    final token =
        await SharedPreferencesClass().readTheData(PreferenceConst.token);
    final username =
        await SharedPreferencesClass().readTheData(PreferenceConst.username);
    final requestHeaders = {
      "clientId": "Client123Cgg",
      "token": token.toString(),
      "userName": username.toString(),
    };
    final _dioObject = Dio();
    try {
      final Response = await _dioObject.post(
        requestUrl,
        options: Options(headers: requestHeaders),
      );
      final _response = DonebyModelClass.fromJson(Response.data);
      setState(() {
        AgencyList = _response.data!;
      });
      final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
      AgencyList.forEach((element) async {
        final Response = DonebyModelResponseTreatment(
            fumigationAgent: element.fumigationAgent, id: element.id);
        final DbCOunt = await _databaseHelper.insertInto(
            Response.toJson(), DatabaseHelper.AgencyList);
        //print("Agency count=$DbCOunt");
        if (AgencyList.length == DbCOunt) {
          print("Agency count=$DbCOunt");
          dbRetrieveAgencyList();
        }
      });
    } on DioError catch (e) {
      print("error");
    }
  }

  showAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return alertWithButton(
            title: "UAT-PQMS",
            descriptions: "Data Saved Successfully",
            Buttontext: "Ok",
            img: Image.asset("assets/correct.png"),
            onButtonPressed: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName(AppRoutes.exportApplnDetails),
              );
            });
      },
    );
  }
}
