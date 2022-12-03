import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/ModelClass/transaction_response.dart';
import 'package:pqms/UI/import_transaction_listitem.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class ImportTransactionDetails extends StatefulWidget {
  const ImportTransactionDetails({super.key});

  @override
  State<ImportTransactionDetails> createState() =>
      _ImportTransactionDetailsState();
}

class _ImportTransactionDetailsState extends State<ImportTransactionDetails> {
  List<TransactionData>? transactiondetails = [];
  FromUser? From_User;
  FromUser? To_User;
  String? TDate;
  String? Tcomments;
  String? Tstatus;
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
              size: 40,
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
                  " Transaction Details",
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
                itemCount: transactiondetails?.length,
                itemBuilder: (context, index) {
                  final userData = transactiondetails![index];
                  return ImportTransactionListItem(
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
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      final String id = ModalRoute.of(context)?.settings.arguments as String;
      // print("init$id");
      getTransactionResponse(id);
    });
  }

  void getTransactionResponse(String id) async {
    var requestURL = BaseUrl.uat_base_url + EndPoints.importtransactindetails;
    //BaseUrl.uat_base_url + EndPoints.importtransactindetails;
    final requestPayload = {
      "data": id, //pass id
    };
    //(data);
    print(id);
    final token =
        await SharedPreferencesClass().readTheData(PreferenceConst.token);
    //print(token.toString());
    final username =
        await SharedPreferencesClass().readTheData(PreferenceConst.username);
    //print(username.toString());
    final requestHeaders = {
      "clientId": "Client123Cgg",
      "token": token.toString(),
      "userName": username.toString(),
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*'
    };
    print(token.toString());
    print(username.toString());

    final _dioObject = Dio();
    print(requestPayload);
    try {
      final _response = await _dioObject.post(
        requestURL,
        data: requestPayload,
        options: Options(headers: requestHeaders),
      );
      print("Data:$_response");
      final responseData = TransactionResponse.fromJson(_response.data);
      //print(responseData);
      setState(() {
        if (responseData.statusCode == 200) {
          transactiondetails = responseData.data;
           EasyLoading.dismiss();
          // if (responseData.data?.length != null) {
          //   print(responseData.data?.length);
          //   for (var i = 0; i < responseData.data!.length; i++) {
          //     print(responseData.data![i].fromUser!.username);
             
          //   }
          // }
        } else if (responseData.statusCode == 400) {
          print(responseData.statusMessage);
        }
      });
    } on DioError catch (e) {
      print("error${e.message}");
    }
  }
}
