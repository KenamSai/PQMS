import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/baseurl_and_endpoints/WebUrlConstants.dart';
import 'package:pqms/reusable/CustomColors.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:webview_flutter/webview_flutter.dart';
//mport 'package:webview_flutter/webview_flutter.dart';

class privacyPolicy extends StatefulWidget {
  const privacyPolicy({super.key});

  @override
  State<privacyPolicy> createState() => _privacyPolicyState();
}

class _privacyPolicyState extends State<privacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UAT-PQMS"),
        centerTitle: true,
        backgroundColor: customColors.colorPQMS,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName(
                  AppRoutes.dashboardpage,
                ),
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
        color: Colors.black.withOpacity(0.3),
        child: ContainedTabBarView(
          tabs: [
            Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 17),
            ),
            Text(
              """Terms and
Conditions""",
              style: TextStyle(fontSize: 17),
            ),
            Text(
              "Copyright Policy",
              style: TextStyle(fontSize: 17),
            )
          ],
          views: [
            Container(
              child: WebView(
                onPageStarted: (url) => EasyLoading.show(),
                onPageFinished: (url) => EasyLoading.dismiss(),
                gestureRecognizers: Set()
                  ..add(
                    Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer(),
                    ),
                  ),
                initialUrl:
                    WebUrlConstants.privacypolicy,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
            Container(
              child: WebView(
                onPageStarted: (url) => EasyLoading.show(),
                onPageFinished: (url) => EasyLoading.dismiss(),
                gestureRecognizers: Set()
                  ..add(
                    Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer(),
                    ),
                  ),
                initialUrl:
                    WebUrlConstants.termsAndConditions,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
            Container(
              child: WebView(
                onPageStarted: (url) => EasyLoading.show(),
                onPageFinished: (url) => EasyLoading.dismiss(),
                gestureRecognizers: Set()
                  ..add(
                    Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer(),
                    ),
                  ),
                initialUrl:
                    WebUrlConstants.copyrightPolicy,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
