import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pqms/ModelClass/import_inspection_response.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/TextReusable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pqms/reusable/imagecallback.dart';

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
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                                readOnly: true,
                                controller: _date,
                                decoration: InputDecoration(
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
                                  _getCurrentPosition();
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
                                      _date.text = formattedDate;
                                    });
                                  }
                                }),
                          ),
                          TextReusable(
                            maxlines: 5,
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
                  // onPressed: () {  },
                  child: Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    _getCurrentPosition();

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
                      Dutyofficer: _DutyOfficer.text,
                      NoofSamples: _NoOfsamples.text,
                      SampleSize: _Samplesize.text,
                      InspectionPlace: _InspectionPlace.text,
                      InspectionDate: _date.text,
                      InspectionRemarks: _InspectionRemarks.text,
                      userimage1: imageData1.path,
                      userimage2: imageData2.path,
                      userimage3: imageData3.path,
                    );
                    final bytes = File(imageData1.path).readAsBytesSync();
                    _DutyOfficer.clear();
                    _NoOfsamples.clear();
                    _Samplesize.clear();
                    _InspectionPlace.clear();
                    _date.clear();
                    _InspectionRemarks.clear();

                    final DatabaseHelper _databaseService =
                        DatabaseHelper.instance;
                    final details = await _databaseService.insertInto(
                        data.toJson(), DatabaseHelper.ImportInspectiontable);
                    print("dbdata:$details");
                    final Entries = await _databaseService
                        .queryAllRows(DatabaseHelper.ImportInspectiontable);
                    print(Entries);
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
    _date.text = "";
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
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
}
