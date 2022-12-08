import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/ModelClass/login_request.dart';
import 'package:pqms/ModelClass/login_response.dart';
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
  TextEditingController _username =  TextEditingController();
  TextEditingController _password =  TextEditingController();
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
            Container(
              margin: EdgeInsets.only(top: 80, left: 50, right: 50, bottom: 50),
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
                        color: Colors.white, fontWeight: FontWeight.bold),
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
                        color: Colors.green[900],
                        child: TextButton(
                          onPressed: () {
                            if (validation()) {
                              getLoginResponse();
                              EasyLoading.show(status: "Loading...");
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
    _username.text = "Ashok_Android";
    _password.text = "PQMS@2022";
  }
  bool validation() {
    if (_username.text.isEmpty) {
      return false;
    } else if (_password.text.isEmpty) {
      //showAlert();
      return false;
    }

    return true;
  }

  Future<void> getLoginResponse() async {
    final requestUrl = BaseUrl.uat_base_url + EndPoints.login;
    final loginrequest = LoginRequest();
    loginrequest.iMEI = "7b1fe3550ff840b2";
    loginrequest.deviceId = "7b1fe3550ff840b2";
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
      final _response = await _dioObject.post(requestUrl,
          data: requestPayload, options: Options(headers: requestHeaders));
      //converting response from json to model cls
      final loginResponse = LoginResponse.fromJson(_response.data);
      //  print(_response.data);
      //  print(loginResponse.statusCode);
      //   print(loginResponse.data?.userName);
      if (loginResponse.statusCode == 200) {
          await SharedPreferencesClass().writeTheData(
              PreferenceConst.username, loginResponse.data?.userName);
          await SharedPreferencesClass()
              .writeTheData(PreferenceConst.token, loginResponse.data?.token);

      EasyLoading.dismiss();

      // String read = await SharedPreferencesClass().readTheData(PreferenceConst.username);
      //    print("login name:$read");
        Navigator.pushNamed(context, AppRoutes.dashboardpage);
      } else if (loginResponse.statusCode == 204) {
        //Alert
      }
    } on DioError catch (e) {
      print(e.message);
      if (e.response?.statusCode == 400 || e.response?.statusCode == 500) {
        //Alert
      }
    }
  }
}
