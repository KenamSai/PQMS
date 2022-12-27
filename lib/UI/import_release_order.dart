import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/ModelClass/importModelClass.dart';
import 'package:pqms/UI/importListItem.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class ImportList extends StatefulWidget {
  const ImportList({super.key});

  @override
  State<ImportList> createState() => _ImportListState();
}

class _ImportListState extends State<ImportList> {
  // importListModelClass? responseData;
  List<Data> dataList = [];
  List<Data> importsearchlist=[];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                  "Import Release Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            dataList.isEmpty
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
                            itemCount: importsearchlist.length,
                            itemBuilder: (context, index) {
                              final userDataa = importsearchlist[index];
                              return ImportListItem(
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
    var requestURL = "https://pqms-uat.cgg.gov.in/pqms/getIROList";
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
      print("response:$_response");
      final responseData = importListModelClass.fromJson(_response.data);
      //print(responseData.data![0].importerName);
      setState(() {
        //this.responseData = responseData;
        //print(responseData.data?.length);
          if (responseData.statusCode == 200) {
          dataList = responseData.data!;
          importsearchlist = dataList;
        }
        ;
        EasyLoading.dismiss();
      });
      //print("${responseData.data?[0].status}");
    } on DioError catch (e) {
      print("error${e.message}");
    }
  }
   _runFilter(String value) {
    List<Data> results = [];
    if (value.isEmpty) {
      results = dataList;
    } else {
      print("entered value is:  $value");
      results = dataList
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
      importsearchlist = results;
    });
  }
}
