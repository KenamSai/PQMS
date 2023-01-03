import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pqms/ModelClass/DutyOfficersResponse.dart';
import 'package:pqms/ModelClass/import_inspection_response.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/reusable/TextReusable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pqms/reusable/alert_dailog.dart';
import 'package:pqms/reusable/imagecallback.dart';
import 'package:pqms/reusable/singlebutton_alert.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';
import '../ModelClass/DutyOfficers.dart';

class ImportInspectionEntry extends StatefulWidget {
  const ImportInspectionEntry({super.key});

  @override
  State<ImportInspectionEntry> createState() => _ImportInspectionEntryState();
}

class _ImportInspectionEntryState extends State<ImportInspectionEntry> {
  TextEditingController _DutyOfficer = TextEditingController();
  TextEditingController _NoOfsamples = TextEditingController();
  TextEditingController _Samplesize = TextEditingController();
  TextEditingController _InspectionPlace = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _InspectionRemarks = TextEditingController();
  TextEditingController _QuantityFound = TextEditingController();
  List<Data> DutyOfficersList = [];
  String? selectedValue;
  int? DutyOfficerId;
  //BuildContext context

  String? _currentAddress;
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    XFile imageData1 = XFile("");
    XFile imageData2 = XFile("");
    XFile imageData3 = XFile("");
    final String id = ModalRoute.of(context)?.settings.arguments as String;
    // final productId = ModalRoute.of(context)!.settings.arguments as String?;
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
                    "Import Inspection Entry",
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
                          TextReusable(
                            data: "Quantity Found",
                            controller: _QuantityFound,
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
                  // onPressed: () {  },
                  child: Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => AppAlertDailog(
                        title: "UAT-PQMS",
                        message:
                            "Data will be stored locally! Do you want to save",
                        icon: Icons.error,
                        yestitle: "Yes",
                        notitle: "No",
                        YesonPressed: () async {
                          if (_currentPosition != null &&
                              _currentPosition!.latitude != null &&
                              _currentPosition!.longitude != null) {
                            print('LAT: ${_currentPosition?.latitude ?? ""}');
                            print('LAT: ${_currentPosition?.longitude ?? ""}');
                            print('ADDRESS: ${_currentAddress ?? ""}');
                          } else {
                            _getCurrentPosition();
                            print("please wait till location is fetched");
                          }

                          final data = ImportResponseinspectionModelClass(
                            applicationId: id,
                            Dutyofficer: selectedValue,
                            DutyOfficerId: DutyOfficerId,
                            NoofSamples: _NoOfsamples.text,
                            SampleSize: _Samplesize.text,
                            InspectionPlace: _InspectionPlace.text,
                            InspectionDate: _date.text,
                            InspectionRemarks: _InspectionRemarks.text,
                            QuantityFound: _QuantityFound.text,
                            inptLocation:
                                _currentPosition!.latitude.toString() +
                                    "," +
                                    _currentPosition!.longitude.toString(),
                            inspctArea: _currentAddress,
                            userimage1: imageData1.path,
                            userimage2: imageData2.path,
                            userimage3: imageData3.path,
                          );
                          var value = DutyOfficerId;
                          print("ID=$value");
                          final bytes = File(imageData1.path).readAsBytesSync();

                          final DatabaseHelper _databaseService =
                              DatabaseHelper.instance;
                          final details = await _databaseService.insertInto(
                              data.toJson(),
                              DatabaseHelper.ImportInspectiontable);
                          print(details);
                          print("dbdata:$details");
                          final Entries = await _databaseService.queryAllRows(
                              DatabaseHelper.ImportInspectiontable);
                          _DutyOfficer.clear();
                          _NoOfsamples.clear();
                          _Samplesize.clear();
                          _InspectionPlace.clear();
                          _date.clear();
                          _InspectionRemarks.clear();
                          _QuantityFound.clear();
                          Navigator.pop(context);
                          showAlert();
                        },
                        NoonPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
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

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    dbRetrieve().then((value) {
      if (DutyOfficersList.isEmpty) {
        getDutyOffcersList();
      }
    });
    _date.text = "";
  }

  getDutyOffcersList() async {
    _date.text = "";
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

  showAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return SingleButtonAlertDailog(
          title: "UAT-PQMS",
          message: "Data Submitted Successfully",
          icon: Icons.done_outline_rounded,
          iconColor: customColors.colorPQMS,
          oktitle: "OK",
          okonPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
