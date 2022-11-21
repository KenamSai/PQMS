import 'package:flutter/cupertino.dart';
import 'package:pqms/UI/Dashboard.dart';
import 'package:pqms/routes/AppRoutes.dart';

class AppPages{
  static Map<String,WidgetBuilder> get routes{
    return{
      AppRoutes.dashboardpage:(context) => Dashboard(),
    };

  }
}