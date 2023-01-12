import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pqms/ModelClass/DonebyModelClass.dart';
import 'package:pqms/ModelClass/DonebyModelResponseTreatment.dart';
import 'package:pqms/ModelClass/DutyOfficersResponse.dart';
import 'package:pqms/ModelClass/import_treatment_response.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/reusable/TextReusable.dart';
import 'package:pqms/reusable/alertWithButtonDone.dart';
import 'package:pqms/reusable/alert_dailog.dart';
import 'package:pqms/reusable/alert_singlebutton.dart';
import 'package:pqms/reusable/alert_withtwo_buttons.dart';
import 'package:pqms/reusable/singlebutton_alert.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';
import '../ModelClass/DutyOfficers.dart';

class ImportTreatmentForm extends StatefulWidget {
  const ImportTreatmentForm({super.key});

  @override
  State<ImportTreatmentForm> createState() => _ImportTreatmentForm();
}

class _ImportTreatmentForm extends State<ImportTreatmentForm> {
  TextEditingController _Dutyofficer = TextEditingController();
  TextEditingController _Chemicals = TextEditingController();
  TextEditingController _Dosage = TextEditingController();
  TextEditingController _Duration = TextEditingController();
  TextEditingController _Temperature = TextEditingController();
  TextEditingController _TreatmentDate = TextEditingController();
  TextEditingController _CompletedDate = TextEditingController();
  TextEditingController _DoneBy = TextEditingController();
  TextEditingController _TreatmentRemarks = TextEditingController();
  String? _currentAddress;
  Position? _currentPosition;

  List<Data> DutyOfficersList = [];
  int? DutyOfficerId;
  String? selectedValue;
  List<DataAgencyList> AgencyList = [];
  List<DonebyModelResponseTreatment> AgencyNameID = [];
  String? selectedAgencyName;
  int? AgencyId;

  @override
  Widget build(BuildContext context) {
    final String? id = ModalRoute.of(context)?.settings.arguments as String?;
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
              flex: 2,
              child: Container(
                child: Center(
                  child: Text(
                    "Import Treatment Form",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
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
                            keyboardtype: TextInputType.number,
                            format: [
                              FilteringTextInputFormatter.allow(
                                RegExp(
                                  r"[0-9.]",
                                ),
                              ),
                            ],
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
                            padding: const EdgeInsets.all(10.0),
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
                            padding: const EdgeInsets.all(10.0),
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
                                            "Completed Date of Supervision?Treatment",
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
                                  //  _getCurrentPosition();
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
                              descriptions: "Please Select Treatment Date",
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
                              descriptions: "Please Select AgencyList",
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
                          builder: (context) => CustomDialogBoxTwoButtons(
                              title: "UAT-PQMS",
                              descriptions:
                                  "Data will be stored locally! Do you want to save?",
                              Buttontext1: "Yes",
                              Buttontext2: "No",
                              img: Image.asset("assets/warning.png"),
                              onButton1Pressed: (() async {
                                final data = ImportTreatmentModelClass(
                                  applicationId: id,
                                  Dutyofficer: selectedValue,
                                  DutyOfficerId: DutyOfficerId,
                                  Chemicals: _Chemicals.text,
                                  Dosage: _Dosage.text,
                                  Duration: _Duration.text,
                                  Temperature: _Temperature.text,
                                  TreatmentDate: _TreatmentDate.text,
                                  CompletedDate: _CompletedDate.text,
                                  DoneBy: selectedAgencyName,
                                  agencyId: AgencyId,
                                  TreatmentRemarks: _TreatmentRemarks.text,
                                  TreatmentLocation: _currentPosition!.latitude
                                          .toString() +
                                      "," +
                                      _currentPosition!.longitude.toString(),
                                  TreatmentArea: _currentAddress,
                                );
                                _Dutyofficer.clear();
                                _Chemicals.clear();
                                _Dosage.clear();
                                _Duration.clear();
                                _Temperature.clear();
                                _TreatmentDate.clear();
                                _CompletedDate.clear();
                                _DoneBy.clear();

                                _TreatmentRemarks.clear();

                                final DatabaseHelper _databaseService =
                                    DatabaseHelper.instance;

                                final details =
                                    await _databaseService.insertInto(
                                        data.toJson(),
                                        DatabaseHelper.ImportTreatmenttable);
                                print("dbdata:$details");
                                final entries =
                                    await _databaseService.queryAllRows(
                                        DatabaseHelper.ImportTreatmenttable);
                                print(entries);
                                Navigator.pop(context);
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
                ModalRoute.withName(AppRoutes.importApplDetails),
              );
            });
      },
    );
                              }),
                              onButton2Pressed: (() {
                                Navigator.pop(context);
                              }))
                          // AppAlertDailog(
                          //   title: "UAT-PQMS",
                          //   message:
                          //       "Data will be stored locally! Do you want to save",
                          //   icon: Icons.error,
                          //   yestitle: "Yes",
                          //   notitle: "No",
                          //   YesonPressed: () async {
                          //     final data = ImportTreatmentModelClass(
                          //       applicationId: id,
                          //       Dutyofficer: selectedValue,
                          //       DutyOfficerId: DutyOfficerId,
                          //       Chemicals: _Chemicals.text,
                          //       Dosage: _Dosage.text,
                          //       Duration: _Duration.text,
                          //       Temperature: _Temperature.text,
                          //       TreatmentDate: _TreatmentDate.text,
                          //       CompletedDate: _CompletedDate.text,
                          //       DoneBy: selectedAgencyName,
                          //       agencyId: AgencyId,
                          //       TreatmentRemarks: _TreatmentRemarks.text,
                          //       TreatmentLocation:
                          //           _currentPosition!.latitude.toString() +
                          //               "," +
                          //               _currentPosition!.longitude.toString(),
                          //       TreatmentArea: _currentAddress,
                          //     );
                          //     _Dutyofficer.clear();
                          //     _Chemicals.clear();
                          //     _Dosage.clear();
                          //     _Duration.clear();
                          //     _Temperature.clear();
                          //     _TreatmentDate.clear();
                          //     _CompletedDate.clear();
                          //     _DoneBy.clear();

                          //     _TreatmentRemarks.clear();

                          //     final DatabaseHelper _databaseService =
                          //         DatabaseHelper.instance;

                          //     final details = await _databaseService.insertInto(
                          //         data.toJson(),
                          //         DatabaseHelper.ImportTreatmenttable);
                          //     print("dbdata:$details");
                          //     final entries = await _databaseService.queryAllRows(
                          //         DatabaseHelper.ImportTreatmenttable);
                          //     print(entries);
                          //     Navigator.pop(context);
                          //     showAlert();
                          //   },
                          //   NoonPressed: () {
                          //     Navigator.pop(context);
                          //   },
                          // ),
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

  @override
  void initState() {
    _TreatmentDate.text = "";
    _CompletedDate.text = "";
    _getCurrentPosition();
    dbRetrieve().then((value) {
      if (DutyOfficersList.isEmpty) {
        getDutyOffcersList();
      }
    });
    dbRetrieveAgencyList().then((value) {
      if (AgencyNameID.isEmpty) {
        getAgencyList();
      }
    });
  }

  void _checkPermission(BuildContext context, Function callback) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      // showDialog(context: context, barrierDismissible: false, builder: (context) => PermissionDialog(isDenied: true, onPressed: () async {
      Navigator.pop(context);
      await Geolocator.requestPermission();
      _checkPermission(context, callback);
      //  }));
    } else if (permission == LocationPermission.deniedForever) {
      // showDialog(context: context, barrierDismissible: false, builder: (context) => PermissionDialog(isDenied: false, onPressed: () async {
      Navigator.pop(context);
      await Geolocator.openAppSettings();
      _checkPermission(context, callback);
      //}));
    } else {
      callback();
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services adre disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.locality}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  getDutyOffcersList() async {
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
  }

  getAgencyList() async {
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
        //print(AgencyList.length);
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
        return SingleButtonAlertDailog(
          title: "UAT-PQMS",
          message: "Data Submitted Successfully",
          icon: Icons.done_outline_rounded,
          oktitle: "OK",
          okonPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
