import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/SplashModel.dart';
import 'package:pqms/UI/appVersion.dart';
import 'package:pqms/baseurl_and_endpoints/baseurl.dart';
import 'package:pqms/baseurl_and_endpoints/endpoints.dart';
import 'package:pqms/reusable/reusableAlert.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/splash.png"),
            fit: BoxFit.cover
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    network();
    //call();
  }

  call() {
    Navigator.pushNamed(context, AppRoutes.Login);
  }

  network() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      getDetails();
    } else if (result == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (context) {
          return reusableAlert(
            title: "UAT-PQMS",
            message: "Please check your internet connection",
            icon: Icons.signal_cellular_connected_no_internet_0_bar_sharp,
            textColor: Colors.red,
          );
        },
      );
    }
  }

  void getDetails() async {
    var requestURL = BaseUrl.finalURL + EndPoints.AppVersion;
    //conversion into form data
    FormData formData = FormData.fromMap({
      "osType": "IOS",
    });
    final requestHeaders = {
      'Content-Type': 'multipart/form-data',
      'Access-Control-Allow-Origin': '*',
    };
    final _dioObeject = Dio();
    try {
      final _response = await _dioObeject.post(
        requestURL,
        data: formData,
        options: Options(headers: requestHeaders),
      );

      final SplashResponse = SplashModelClass.fromJson(_response.data);

      if (SplashResponse.statusCode == 200) {
        final versionNumber = await appVersion().getAppVersion();
       
        print("local: $versionNumber");
        print("api: ${SplashResponse.data?.versionNumber}");

        if (SplashResponse.data?.versionNumber != null &&
            versionNumber == "${SplashResponse.data?.versionNumber}.0") {
          final snack = SnackBar(
            content: Text(
              "${SplashResponse.statusMessage}",
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          Navigator.pushNamed(context, AppRoutes.Login);
          await SharedPreferencesClass().writeTheData(PreferenceConst.versionNumber,SplashResponse.data?.versionNumber );
          await SharedPreferencesClass().writeTheData(PreferenceConst.versionUpdateDate, SplashResponse.data?.versionDate);      
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return reusableAlert(
                title: "UAT-PQMS",
                message: "Upgrade Your App",
                icon: Icons.upgrade,
                textColor: Colors.green,
                iconColor: Colors.deepPurple,
              );
            },
          );
        }
      }
    } on DioError catch (e) {
      //print("response is ${e.response?.statusCode}");
      showDialog(
        context: context,
        builder: (context) {
          return reusableAlert(
            title: "UAT-PQMS",
            message: "Unable to connect",
            icon: Icons.error_outline_rounded,
            textColor: Colors.red,
          );
        },
      );
    }
  }
}
