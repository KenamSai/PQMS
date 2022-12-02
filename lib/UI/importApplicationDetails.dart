import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/ModelClass/importApplModelClass.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class importApplicationDetails extends StatefulWidget {
  const importApplicationDetails({super.key});

  @override
  State<importApplicationDetails> createState() =>
      _importApplicationDetailsState();
}

class _importApplicationDetailsState extends State<importApplicationDetails> {
  DataDetails? modelDetails;
  bool? treatment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("UAT-PQMS"),
        backgroundColor: Colors.green[900],
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName("/Dashboard"),
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
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "    Import Application Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 14,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          RowComponent(
                            "Application Id",
                            modelDetails?.applicationId,
                          ),
                          RowComponent(
                            "Importer Name",
                            modelDetails?.importerName,
                          ),
                          RowComponent(
                            "Importer Address",
                            modelDetails?.importerAddress,
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          RowComponent(
                            "Exporter Name",
                            modelDetails?.exporterName,
                          ),
                          RowComponent(
                            "Exporter Address",
                            modelDetails?.exporterAddress,
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          RowComponent(
                            "Applied To",
                            modelDetails?.appliedFor,
                          ),
                          RowComponent(
                            "Import purpose",
                            modelDetails?.importPurpose,
                          ),
                          RowComponent(
                            "Bill Entry Number",
                            modelDetails?.bENo,
                          ),
                          RowComponent(
                            "B/E Date",
                            modelDetails?.bEDate,
                          ),
                          RowComponent(
                            "Commodity",
                            modelDetails?.commodity,
                          ),
                          RowComponent(
                            "Country of Re-export",
                            modelDetails?.countryReExport,
                          ),
                          RowComponent(
                            "Quantity",
                            modelDetails?.quantity,
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          RowComponent(
                            "Necessary Documenst",
                            modelDetails?.necessarydocuments,
                          ),
                          RowComponent(
                            "variety",
                            modelDetails?.variety,
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          RowComponent(
                            "Mode Of Packing",
                            modelDetails?.packingMode,
                          ),
                          RowComponent(
                            "No of Packages",
                            modelDetails?.noOfPackages,
                          ),
                          RowComponent(
                            "Vessel Name",
                            modelDetails?.vessalName,
                          ),
                          RowComponent(
                            "Country of Origin",
                            modelDetails?.countryOrigin,
                          ),
                          RowComponent(
                            "Value of Commodity",
                            modelDetails?.commodityValue,
                          ),
                          RowComponent(
                            "PSC No",
                            modelDetails?.pscNo,
                          ),
                          RowComponent(
                            "PSC Date",
                            modelDetails?.pscDate,
                          ),
                          RowComponent(
                            "Plant part",
                            modelDetails?.plantPart,
                          ),
                          RowComponent(
                            "Scientific Name",
                            modelDetails?.scientificName,
                          ),
                          RowComponent(
                            "Point Of Entry",
                            modelDetails?.pointOfEntry,
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          RowComponent(
                            "Means Of Conveyance",
                            modelDetails?.meansOfConveyance,
                          ),
                          RowComponent(
                            "Distinguish Mark",
                            modelDetails?.distinguishingMarks,
                          ),
                          RowComponent(
                            "category",
                            modelDetails?.category,
                          ),
                          RowComponent(
                            "Foreign Port of Shipment",
                            modelDetails?.foreignPortShipment,
                          ),
                          RowComponent(
                            "Date Of Arrival",
                            modelDetails?.dateOfArrival,
                          ),
                          RowComponent(
                            "Place Of Inspection",
                            modelDetails?.inspectionPlace,
                          ),
                          RowComponent(
                            "Date of Inspection",
                            modelDetails?.inspectionDate,
                          ),
                          RowComponent(
                            "Current Status",
                            modelDetails?.status,
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Documents Submitted",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              // fontSize: 15
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage("assets/bg.png"),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.importTransactionDetails);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        width: 380,
                        height: 32.0,
                        child: Center(
                          child: Text(
                            "VIEW TRANSACTION DETAILS",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    if (!(modelDetails?.treatmentNeeded ?? false))
                      ...[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.inspectiondetails);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            height: 32.0,
                            width: 380,
                            child: Center(
                              child: Text(
                                "INSPECTION",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ]
                    else
                      ...[
                          Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            //Navigate to Inspection
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            height: 32.0,
                            width: 183,
                            child: Center(
                              child: Text(
                                "INSPECTION",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //Navigate to Treatment
                          },
                          child: Container(
                            width: 183,
                            height: 32.0,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "TREATMENT",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                      ],
                  
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 10, bottom: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(fontSize: 17),
            ),
          )
        ],
      ),
    );
  }

  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then(
      (value) {
        final String id = ModalRoute.of(context)?.settings.arguments as String;
        // print("init$id");
        getDetails(id);
      },
    );
    // print("init :$id");
  }

  void getDetails(String id) async {
    var requestURL = "https://pqms-uat.cgg.gov.in/pqms/getIroAppDetails";
    final requestPayload = {
      "data": id, //pass id
    };
    // print("dataID:$dataId");
    final token = SharedPreferencesClass().readTheData(PreferenceConst.token);
    final username =
        SharedPreferencesClass().readTheData(PreferenceConst.username);
    final requestHeaders = {
      "clientId": "Client123Cgg",
      "token": token.toString(),
      "userName": username.toString(),
    };
    final _dioObject = Dio();
    try {
      final _response = await _dioObject.post(
        requestURL,
        data: requestPayload,
        options: Options(headers: requestHeaders),
      );
      print("Data:$_response");
      final responseData = importApplDetailsModelClass.fromJson(_response.data);
      //print(responseData);
      setState(() {
        if (responseData.statusCode == 200) {
          modelDetails = responseData.data;
          treatment = responseData.data?.treatmentNeeded;
          print("$treatment");
          EasyLoading.dismiss();
        } else {
          print("else");
        }
      });
    } on DioError catch (e) {
      print("error${e.message}");
    }
  }
}
