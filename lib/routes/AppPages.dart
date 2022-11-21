import 'package:flutter/cupertino.dart';
import 'package:pqms/UI/Dashboard.dart';
import 'package:pqms/UI/export_list.dart';
import 'package:pqms/UI/import_list.dart';
import 'package:pqms/UI/login.dart';
import 'package:pqms/UI/view_saved_app.dart';
import 'package:pqms/routes/AppRoutes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.dashboardpage: (context) => Dashboard(),
      AppRoutes.Login: (context) => LoginScreen(),
      AppRoutes.importpermit: (context) => ImportList(),
      AppRoutes.exportpermit: (context) => ExportList(),
      AppRoutes.viewpermit: (context) => ViewSavedApplication(),
    };
  }
}
