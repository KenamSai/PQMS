import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/importModelClass.dart';
import 'package:pqms/UI/ListItem.dart';

class ImportList extends StatefulWidget {
  const ImportList({super.key});

  @override
  State<ImportList> createState() => _ImportListState();
}

class _ImportListState extends State<ImportList> {
  late importModelClass modelData;
  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Import Release Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: modelData.data?.length,
                itemBuilder: (context, index) {
                  final userData = modelData.data?[index];
                  return ImportListItem(
                    userInfo: userData,
                  );
                },
              )
            ],
          ),
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
    final requestHeaders = {
      "clientId": "Client123Cgg",
      "token":
          "ZGFtViiyLx0g7fImDEuoyZeISGEHDdJbby5PiRgbjGYNZojDUha0s42+TQPoXLJE",
      "userName": "Ashok_Android"
    };
    final _dioObject = Dio();
    try {
      final _response = await _dioObject.post(
        requestURL,
        data: requestPayload,
        options: Options(headers: requestHeaders),
      );
      print(_response);
      final responseData = importModelClass.fromJson(_response.data);
      print(responseData);
      setState(() {
        modelData = responseData;
        print(modelData.data?.length);
      });
      //print("${responseData.data?[0].status}");
    } on DioError catch (e) {
      print("error${e.message}");
    }
  }
}
