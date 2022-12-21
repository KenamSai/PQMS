import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pqms/ModelClass/DutyOfficers.dart';
import 'package:pqms/ModelClass/DutyOfficersResponse.dart';
import 'package:pqms/ModelClass/exportInspectionResponseModelClass.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/reusable/TextReusable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pqms/reusable/imagecallback.dart';
import 'package:pqms/reusable/reusableAlert.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class ExportInspectionEntry extends StatefulWidget {
  const ExportInspectionEntry({super.key});

  @override
  State<ExportInspectionEntry> createState() => _ExportInspectionEntryState();
}

class _ExportInspectionEntryState extends State<ExportInspectionEntry> {
  TextEditingController _NoOfsamples = TextEditingController();
  TextEditingController _Samplesize = TextEditingController();
  TextEditingController _InspectionPlace = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _InspectionRemarks = TextEditingController();
  List<Data> DutyOfficersList = [];
  String? selectedValue;
  int? DutyOfficerId;
  @override
  void initState() {
    dbRetrieve().then((value) {
      //print(DutyOfficersList.length);
      if (DutyOfficersList.isEmpty) {
        getDutyOffcersList();
      }
    });
  }

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
                                      setState(() {
                                        selectedValue = changedValue;
                                        if (selectedValue != "") {
                                          DutyOfficersList.forEach((element) {
                                            if (selectedValue == element.name) {
                                              DutyOfficerId = element.id;
                                            }
                                          });
                                        }
                                      });
                                    },
                                    items:
                                        DutyOfficersList.map((DutyOfficerName) {
                                      return new DropdownMenuItem<String>(
                                        value: DutyOfficerName.name,
                                        child: Text(DutyOfficerName.name ?? ""),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    onPressed: (() {
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
                                      getDutyOffcersList();
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
                                  },
                                ),
                                ImgPickerCamera(
                                  callbackValue: (imageData) {
                                    imageData2 = imageData;
                                  },
                                ),
                                ImgPickerCamera(
                                  callbackValue: (imageData) {
                                    imageData3 = imageData;
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
                  onPressed: () async {
                    final data = exportResponseinspectionModelClass(
                      applicationId: id,
                      dutyofficer: selectedValue,
                      dutyofficerId: DutyOfficerId,
                      noofSamples: _NoOfsamples.text,
                      inspectionDate: _date.text,
                      sampleSize: _Samplesize.text,
                      inspectionPlace: _InspectionPlace.text,
                      inspectionRemarks: _InspectionRemarks.text,
                      userimage1: imageData1.path,
                      userimage2: imageData2.path,
                      userimage3: imageData3.path,
                    );

                    final DatabaseHelper _databaseService =
                        DatabaseHelper.instance;
                    final details = await _databaseService.insertInto(
                        data.toJson(), DatabaseHelper.ExportInspectiontable);
                    print("dbdata:$details");
                    showDialog(
                      context: context,
                      builder: (context) {
                        return reusableAlert(
                          title: "Message",
                          message: "Data submitted Successfully!",
                          icon: Icons.done_outline_sharp,
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

  getDutyOffcersList() async {
    _date.text = "";
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
}
