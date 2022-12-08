import 'package:flutter/cupertino.dart';
import 'package:pqms/UI/Dashboard.dart';
import 'package:pqms/UI/ExportApplicationDetails.dart';
import 'package:pqms/UI/ExportInspectionEntry.dart';
import 'package:pqms/UI/ExportReleaseOrder.dart';
import 'package:pqms/UI/ExportSavedApplications.dart';
import 'package:pqms/UI/SplashScreen.dart';
import 'package:pqms/UI/ViewSavedApplns.dart';
import 'package:pqms/UI/exportInspectionSaved.dart';
import 'package:pqms/UI/exportTreatmentSubmit.dart';
import 'package:pqms/UI/exportTreatmentsaved.dart';
import 'package:pqms/UI/export_treatment%20entry.dart';
import 'package:pqms/UI/importApplicationDetails.dart';
import 'package:pqms/UI/importInspectionEntry.dart';
import 'package:pqms/UI/importTransactionDetails.dart';
import 'package:pqms/UI/import_inspection_saved_application.dart';
import 'package:pqms/UI/import_inspection_submit.dart';
import 'package:pqms/UI/import_release_order.dart';
import 'package:pqms/UI/import_treatment_form.dart';
import 'package:pqms/UI/import_treatment_saved_application.dart';
import 'package:pqms/UI/importsavedApplication.dart';
import 'package:pqms/UI/login.dart';
import 'package:pqms/UI/privacyPolicy.dart';
import 'package:pqms/demo.dart';
import 'package:pqms/routes/AppRoutes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.dashboardpage: (context) => Dashboard(),
      AppRoutes.Login: (context) => LoginScreen(),
      AppRoutes.importrelease: (context) => ImportList(),
      AppRoutes.exportrelease:(context) => ExportList(),
      AppRoutes.Splash:(context) => SplashScreen(),
      AppRoutes.bgreusable:(context) => demo(),
      AppRoutes.importApplDetails:(context) => importApplicationDetails(),
      AppRoutes.privacy:(context) => privacyPolicy(),
      AppRoutes.ViewSavedAppln:(context) => ViewSavedApplication(),
      AppRoutes.importsaved:(context) => ImportSavedApplication(),
      AppRoutes.exportsaved:(context) => ExportSavedApplication(),
      AppRoutes.exportApplnDetails:(context) =>ExportApplicationDetails(),
      AppRoutes.importTransactionDetails:(context) => ImportTransactionDetails(),
      AppRoutes.exportinspection:(context) => ExportInspectionEntry(),
      AppRoutes.importinspection:(context) => ImportInspectionEntry(),
      AppRoutes.importtreatment:(context) => ImportTreatmentForm(),
      AppRoutes.exporttreatment:(context) => ExportTreatmentForm(),
      AppRoutes.exporttreatmentsaved:(context) => exportTreatmentSaved(),
      AppRoutes.exportinspectionsaved:(context) => exportInspectionSaved(),
      AppRoutes.exporttreatmentSubmission:(context) => ExportTreatmentSubmit(),
      AppRoutes.importinspectionsaved:(context) => ImportInspectionSavedApplications(),
      AppRoutes.importtreatmentsaved:(context) => ImportTreatmentSavedApplications(),
      AppRoutes.importinspectionformsubmit:(context) => ImportInspectionSubmit(),
      
    };
  }
}
