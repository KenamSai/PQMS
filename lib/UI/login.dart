import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/ModelClass/login_request.dart';
import 'package:pqms/ModelClass/login_response.dart';
import 'package:pqms/reusable/alert_singlebutton.dart';
import 'package:pqms/reusable/deviceID.dart';
import 'package:pqms/reusable/singlebutton_alert.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  TextEditingController _username = TextEditingController(text: "Rekha_Mobile");
  TextEditingController _password = TextEditingController(text: "PQMS@2022");
  String versionNumber = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage("assets/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Version: uat $versionNumber",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 50),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage("assets/app_icon.png"),
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "Officer Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: SizedBox(
                      width: 340,
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                          controller: _username,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Username",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                    child: SizedBox(
                      width: 340,
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                          controller: _password,
                          obscureText: !_isPasswordVisible,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: SizedBox(
                      width: 340,
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                        child: TextButton(
                          onPressed: () async {
                            if (validation()) {
                              var result =
                                  await Connectivity().checkConnectivity();

                              if (result == ConnectivityResult.mobile ||
                                  result == ConnectivityResult.wifi) {
                                EasyLoading.show(status: "Loading...");
                                getLoginResponse();
                              } else {
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
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomSheet: Image.asset(
          "assets/headerpic.png",
          width: double.infinity,
          height: 40,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVersionNumber();
  }

  @override
  bool validation() {
    if (_username.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return SingleButtonDialogBox(
              title: "UAT-PQMS",
              descriptions: "Please Enter Username",
              Buttontext: "Ok",
              img: Image.asset("assets/caution.png"),
              onPressed: () {
                Navigator.pop(context);
              });
        },
      );
      return false;
    } else if (_password.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return SingleButtonDialogBox(
              title: "UAT-PQMS",
              descriptions: "Please Enter Password",
              Buttontext: "Ok",
              img: Image.asset("assets/caution.png"),
              onPressed: () {
                Navigator.pop(context);
              });
        },
      );
      return false;
    }

    return true;
  }

  Future<void> getLoginResponse() async {
    final requestUrl = BaseUrl.finalURL + EndPoints.login;
    final loginrequest = LoginRequest();
    loginrequest.iMEI = await Utils().getDeviceId();
    loginrequest.deviceId = await Utils().getDeviceId();
    print(loginrequest.deviceId);
    loginrequest.username = _username.text.toString().trim();
    loginrequest.password = _password.text.toString().trim();
    loginrequest.toJson();
    // print(loginrequest.toJson());
    final requestPayload = loginrequest.toJson();
    Map<String, String> requestHeaders = {
      'clientId': 'Client123Cgg',
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*'
    };
    final _dioObject = Dio();

    try {
      final _response = await _dioObject.post(
        requestUrl,
        data: requestPayload,
        options: Options(headers: requestHeaders),
      );
      //converting response from json to model cls
      final loginResponse = LoginResponse.fromJson(_response.data);

      if (loginResponse.statusCode == 200) {
        await SharedPreferencesClass().writeTheData(
            PreferenceConst.username, loginResponse.data?.userName);
        await SharedPreferencesClass()
            .writeTheData(PreferenceConst.token, loginResponse.data?.token);
        await SharedPreferencesClass().writeTheData(
            PreferenceConst.upcomingId, loginResponse.data!.userId);

        EasyLoading.dismiss();
        Navigator.pushNamed(context, AppRoutes.dashboardpage);
      } else if (loginResponse.statusCode == 204) {
        EasyLoading.dismiss();
        showDialog(
          context: context,
          builder: (context) {
            return SingleButtonDialogBox(
                title: "UAT-PQMS",
                descriptions: loginResponse.statusMessage!,
                Buttontext: "Ok",
                img: Image.asset("assets/caution.png"),
                onPressed: () {
                  Navigator.pop(context);
                });
          },
        );
      }
    } on DioError catch (e) {
      print(e.message);
      if (e.response?.statusCode == 400 || e.response?.statusCode == 500) {}
    }
  }

  getVersionNumber() async {
    String value = await SharedPreferencesClass()
        .readTheData(PreferenceConst.versionNumber);
    setState(() {
      versionNumber = value;
    });
  }
}