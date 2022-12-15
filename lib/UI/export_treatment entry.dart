import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pqms/ModelClass/DonebyModelClass.dart';
import 'package:pqms/ModelClass/exportInspectionResponseModelClass.dart';
import 'package:pqms/ModelClass/exporttreatmentresponsemodel.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/TextReusable.dart';
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
  List<DataAgencyList> dataAgency = [];
  DataAgencyList? selectedValue;
    List<Data> DutyOfficersList = [];
  int? DutyOfficerId;
  Data? selectedValuetype;

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
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
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
                                  flex: 2,
                                  child: DropdownButton<Data>(
                                    value: selectedValuetype,
                                    underline: Container(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    isExpanded: true,
                                    onChanged: (changedValue) {
                                      setState(() {
                                        selectedValuetype = changedValue;
                                      });
                                    },
                                    items: DutyOfficersList.map((Data value) {
                                      return new DropdownMenuItem<Data>(
                                        value: value,
                                        child: Text(value.name ?? ""),
                                      );
                                    }).toList(),
                                  ),
                                ),
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
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Done by",
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
                                  flex: 2,
                                  child: DropdownButton<DataAgencyList>(
                                  
                                    value: selectedValue,
                                    underline: Container(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    isExpanded: true,
                                    onChanged: ((value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    }),
                                    items:
                                        dataAgency.map((DataAgencyList value) {
                                      return new DropdownMenuItem<
                                          DataAgencyList>(
                                        value: value,
                                        child: Text(
                                          value.fumigationAgent ?? "",
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
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
                    // print("id$id");
                    // print("date${_CompletedDate.text}");
                    final Response = exporttreatmentresponsemodelclass(
    
                        applicationId: id.toString(),
                        chemicals: _Chemicals.text,
                        completionDate: _CompletedDate.text,
                        treatmentDate: _TreatmentDate.text,
                        doneby: selectedValue!.fumigationAgent,
                        dosage: _Dosage.text,
                        durationHrs: _Duration.text,
                        dutyofficer: selectedValuetype!.name,
                        temperatureDegC: _Temperature.text,
                        treatmentRemarks: _TreatmentRemarks.text);

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
                    final DBdetails = await _databaseService.insertInto(
                        Response.toJson(), "ExportTreatment");
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

  @override
  void initState() {
    // TODO: implement initState

    getAgencyList();
    getDutyOffcersList();
  }
  void getAgencyList() async {
    String requestUrl = "https://pqms-uat.cgg.gov.in/pqms/agenciesList";
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
        options: Options(headers: requestHeaders),
      );
      final dataResponse = DonebyModelClass.fromJson(_response.data);
      setState(() {
        dataAgency = dataResponse.data!;
      });

    } catch (e) {}
  }
  getDutyOffcersList() async {

    String requestUrl =
        "https://pqms-uat.cgg.gov.in/pqms/getEmployeeListByRole";
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
      setState(() {
        DutyOfficersList = dataResponse.data!;
      });
    } on DioError catch (e) {
      print("error");
    }
}
}
