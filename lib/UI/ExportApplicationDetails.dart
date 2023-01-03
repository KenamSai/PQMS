import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/ModelClass/DonebyModelClass.dart';
import 'package:pqms/ModelClass/DonebyModelResponseTreatment.dart';
import 'package:pqms/ModelClass/ExportApplicationModelClass.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/db/DatabaseHelper.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class ExportApplicationDetails extends StatefulWidget {
  const ExportApplicationDetails({super.key});

  @override
  State<ExportApplicationDetails> createState() =>
      _ExportApplicationDetailsState();
}

class _ExportApplicationDetailsState extends State<ExportApplicationDetails> {
  List<DataAgencyList> AgencyList = [];
  List<DonebyModelResponseTreatment> AgencyNameID = [];
  String? selectedAgencyName;
  DataApplicationDetails? exportmodelDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("UAT-PQMS"),
        backgroundColor: customColors.colorPQMS,
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
                alignment: Alignment.centerLeft,
                child: Text(
                  "    Export Application Details",
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
                            exportmodelDetails?.applicationId,
                          ),
                          RowComponent(
                            "Exporter Name",
                            exportmodelDetails?.importerName,
                          ),
                          RowComponent(
                            "Exporter Address",
                            exportmodelDetails?.importerAddress,
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
                            "Importer Name",
                            exportmodelDetails?.exporterName,
                          ),
                          RowComponent(
                            "Importer Address",
                            exportmodelDetails?.exporterAddress,
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
                            "Export Purpose",
                            exportmodelDetails?.purposeofExport,
                          ),
                          RowComponent(
                            "Commodity",
                            exportmodelDetails?.commodity,
                          ),
                          RowComponent(
                            "Export Of Country",
                            exportmodelDetails?.countrytoExport,
                          ),
                          RowComponent(
                            "Quantity",
                            exportmodelDetails?.quantity,
                          ),
                          RowComponent(
                            "Necessary Documents",
                            exportmodelDetails?.necessaryDocuments,
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
                            "Scientific Name",
                            exportmodelDetails?.scientificName,
                          ),
                          RowComponent(
                            "PSC No",
                            exportmodelDetails?.pscNo,
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
                            exportmodelDetails?.packingMode,
                          ),
                          RowComponent(
                            "Place Of Origin",
                            exportmodelDetails?.placeofOrigin,
                          ),
                          RowComponent(
                            "Port Of Loading",
                            exportmodelDetails?.portofLoading,
                          ),
                          RowComponent(
                            "No of Packages",
                            exportmodelDetails?.noOfPackages,
                          ),
                          RowComponent(
                            "Country of Origin",
                            exportmodelDetails?.countryOrigin,
                          ),
                          RowComponent(
                            "Value Of Commodity",
                            exportmodelDetails?.valueofCommodity,
                          ),
                          RowComponent(
                            "Plant Part",
                            exportmodelDetails?.plantPart,
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
                            exportmodelDetails?.meansOfConveyance,
                          ),
                          RowComponent(
                            "Invoice No",
                            exportmodelDetails?.invoiceNo,
                          ),
                          RowComponent(
                            "Invoice Date",
                            exportmodelDetails?.invoiceDate,
                          ),
                          RowComponent(
                            "Category",
                            exportmodelDetails?.category,
                          ),
                          RowComponent(
                            "Quantity in Volume",
                            exportmodelDetails?.quantityinVolume,
                          ),
                          RowComponent(
                            "Commodity Desc",
                            exportmodelDetails?.commodityDesc,
                          ),
                          RowComponent(
                            "Inspection outside Pqms",
                            exportmodelDetails?.inspectionOutsidepqms,
                          ),
                          RowComponent(
                            "Treatment Needed",
                            exportmodelDetails?.treatmentNeeded,
                          ),
                          RowComponent(
                            "Foreign Port Of Shipment",
                            exportmodelDetails?.foreignportofShipment,
                          ),
                          RowComponent(
                            "Place Of Inspection",
                            exportmodelDetails?.placeofInspection,
                          ),
                          RowComponent(
                            "No Of Containers",
                            exportmodelDetails?.status,
                          ),
                          RowComponent(
                            "Date Of Inspection",
                            exportmodelDetails?.inspectionDate,
                          ),
                          RowComponent(
                            "Current Status",
                            exportmodelDetails?.status,
                          ),
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
                      onTap: (() {
                        Navigator.pushNamed(
                            context, AppRoutes.importTransactionDetails,
                            arguments: exportmodelDetails?.applicationId);
                        EasyLoading.show(status: "Loading...");
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 32.0,
                        child: Center(
                          child: Text(
                            "VIEW TRANSACTION DETAILS",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (!(exportmodelDetails?.treatmentNeeded ?? true))
                          GestureDetector(
                            onTap: (() {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.exportinspection,
                                arguments: exportmodelDetails?.applicationId,
                              );
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              height: 32,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Center(
                                child: Text(
                                  "INSPECTION",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          )
                        else ...[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.exportinspection,
                                      arguments:
                                          exportmodelDetails?.applicationId,
                                    );
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    height: 32.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
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
                                  onTap: (() {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.exporttreatment,
                                      arguments:
                                          exportmodelDetails?.applicationId,
                                    );
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    height: 32.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
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
                            ),
                          ),
                        ],
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      final id = ModalRoute.of(context)?.settings.arguments as String;
      //print(id);
      getApplnDetails(id);
    });
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
          SizedBox(
            width: 10,
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

  void getApplnDetails(String id) async {
    var requestURL = BaseUrl.uat_base_url+EndPoints.getPSCAppDetails;
    final requestPayload = {
      "data": id, //pass id
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
        requestURL,
        data: requestPayload,
        options: Options(headers: requestHeaders),
      );
      final responseData =
          ExportApplicationDetailsModelClass.fromJson(_response.data);
      setState(() {
        if (responseData.statusCode == 200) {
          exportmodelDetails = responseData.data;
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
