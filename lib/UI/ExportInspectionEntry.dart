import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pqms/ModelClass/DutyOfficers.dart';
import 'package:pqms/ModelClass/DutyOfficersResponse.dart';
import 'package:pqms/ModelClass/exportInspectionResponseModelClass.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/reusable/TextReusable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pqms/reusable/alertWithButtonDone.dart';
import 'package:pqms/reusable/alert_singlebutton.dart';
import 'package:pqms/reusable/alert_withtwo_buttons.dart';
import 'package:pqms/reusable/imagecallback.dart';
import 'package:pqms/reusable/reusableAlert.dart';
import 'package:pqms/reusable/singlebutton_alert.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class ExportInspectionEntry extends StatefulWidget {
  const ExportInspectionEntry({super.key});

  @override
  State<ExportInspectionEntry> createState() => _ExportInspectionEntryState();
}

class _ExportInspectionEntryState extends State<ExportInspectionEntry> {
  String? _currentAddress;
  Position? _currentPosition;
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
    _getCurrentPosition();
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
        backgroundColor: customColors.colorPQMS,
        title: Text(
          "UAT-PQMS",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
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
                                    onPressed: (() async {
                                      var result = await Connectivity()
                                          .checkConnectivity();
                                      if (result == ConnectivityResult.mobile ||
                                          result == ConnectivityResult.wifi) {
                                        DutyOfficersList.forEach(
                                            (element) async {
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
                            data: "No Samples",
                            controller: _NoOfsamples,
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
                            data: "Sample size",
                            controller: _Samplesize,
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
                    } else if (_InspectionPlace.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogBox(
                              title: "UAT-PQMS",
                              descriptions: "Please Select Inspection Place",
                              Buttontext: "ok",
                              img: Image.asset("assets/caution.png"),
                              onPressed: (() {
                                Navigator.pop(context);
                              }));
                        },
                      );
                    } else if (_date.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogBox(
                              title: "UAT-PQMS",
                              descriptions:
                                  "Please Select Completed Inspection Date",
                              Buttontext: "ok",
                              img: Image.asset("assets/caution.png"),
                              onPressed: (() {
                                Navigator.pop(context);
                              }));
                        },
                      );
                    } else if (_InspectionRemarks.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogBox(
                              title: "UAT-PQMS",
                              descriptions: "Please Enter Inspection Remarks",
                              Buttontext: "ok",
                              img: Image.asset("assets/caution.png"),
                              onPressed: (() {
                                Navigator.pop(context);
                              }));
                        },
                      );
                    } else if (imageData1.path.isEmpty &&
                        imageData2.path.isEmpty &&
                        imageData3.path.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogBox(
                              title: "UAT-PQMS",
                              descriptions: "Please Capture atleast one image",
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
                                  inspctArea: _currentAddress,
                                  inspctLocation: _currentPosition!.latitude
                                          .toString() +
                                      "," +
                                      _currentPosition!.longitude.toString(),
                                );
                                print("Area:$_currentAddress");
                                print("LAT,LONG:$_currentPosition");
                                final DatabaseHelper _databaseService =
                                    DatabaseHelper.instance;
                                final details =
                                    await _databaseService.insertInto(
                                        data.toJson(),
                                        DatabaseHelper.ExportInspectiontable);
                                print("dbdata:$details");
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
                ModalRoute.withName(AppRoutes.exportrelease),
              );
            });
      },
    );
  }

  getDutyOffcersList() async {
    _date.text = "";
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi){
      EasyLoading.show(
          status: "Loading...", maskType: EasyLoadingMaskType.black);
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
        EasyLoading.dismiss();
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
        else{
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location services are disabled. Please enable the services',
          ),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Location permissions are denied',
            ),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location permissions are permanently denied, we cannot request permissions.',
          ),
        ),
      );
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
    }).catchError(
      (e) {
        debugPrint(e);
      },
    );
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then(
      (List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        setState(
          () {
            _currentAddress =
                '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.locality}, ${place.postalCode}';
            print(_currentAddress);
          },
        );
      },
    ).catchError(
      (e) {
        debugPrint(e);
      },
    );
  }

  bool validation() {
    if (true) {
      showDialog(
        context: context,
        builder: (context) {
          return SingleButtonAlertDailog(
            title: "UAT-PQMS",
            message: "Please Enter Username",
            icon: Icons.error,
            iconColor: Colors.red,
            oktitle: "OK",
            okonPressed: () {
              Navigator.pop(context);
            },
          );
        },
      );
      return false;
    }
    return true;
  }
}
