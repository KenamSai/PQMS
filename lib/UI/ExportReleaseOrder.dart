import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/ModelClass/exportListModel.dart';
import 'package:pqms/UI/ExportListItem.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class ExportList extends StatefulWidget {
  const ExportList({super.key});

  @override
  State<ExportList> createState() => _ExportList();
}

class _ExportList extends State<ExportList> {
  List<ExportData> exportList = [];
  List<ExportData> exportSearchedList = [];
  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: customColors.colorPQMS,
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: "  Application Id or Commodity",
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  "Export Release Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            exportList.isEmpty
                ? Expanded(
                    flex: 10,
                    child: Center(
                      child: Text(
                        "No Application Available",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    flex: 18,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: exportSearchedList.length,
                            itemBuilder: (context, index) {
                              final userDataa = exportSearchedList[index];
                              return ExportListItem(
                                userInfo: userDataa,
                              );
                            },
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
    getDetails();
  }

  getDetails() async {
    var requestURL = "https://pqms-uat.cgg.gov.in/pqms/getPSCList";
    final requestPayload = {
      "data": "Inspector",
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
      //print(_response);
      final responseData = ExportList_Model.fromJson(_response.data);
      //print(responseData);
      setState(() {
        if (responseData.statusCode == 200) {
          exportList = responseData.data!;
          exportSearchedList = exportList;
        }
        ;
        EasyLoading.dismiss();
      });
      // print("on top:${responseData.data?[0].status}");
    } on DioError catch (e) {
      print("error${e.message}");
    }
  }

  _runFilter(String value) {
    List<ExportData> results = [];
    if (value.isEmpty) {
      results = exportList;
    } else {
      print("entered value is:  $value");
      results = exportList
          .where(
            (element) =>
                element.applicationId!.toLowerCase().startsWith(
                      value.toLowerCase(),
                    ) ||
                element.commodity!.toLowerCase().startsWith(
                      value.toLowerCase(),
                    ),
          )
          .toList();
    }
    setState(() {
      exportSearchedList = results;
    });
  }
}
