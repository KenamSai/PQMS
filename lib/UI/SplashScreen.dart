import 'package:dio/dio.dart';
import 'package:pqms/ModelClass/SplashModel.dart';
import 'package:flutter/material.dart';
import 'package:pqms/UI/appVersion.dart';
import 'package:pqms/reusable/reusableAlert.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
        child: Image.asset(
          "assets/splash.png",
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    //network();
    call();
  }

call(){Navigator.pushNamed(context, AppRoutes.Login);}
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
    var requestURL = "https://pqms-uat.cgg.gov.in/pqms/getCurrentAppVersion";
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


        if (SplashResponse.data?.versionNumber != null &&
            versionNumber == SplashResponse.data?.versionNumber) {
          final snack = SnackBar(
            content: Text(
              "${SplashResponse.data?.statusMessage}",
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          Navigator.pushNamed(context, AppRoutes.Login);
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
