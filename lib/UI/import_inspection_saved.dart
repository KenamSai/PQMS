// import 'package:flutter/material.dart';


// class ImportInspectionSavedApplications extends StatefulWidget {
//   const ImportInspectionSavedApplications({super.key});

//   @override
//   State<ImportInspectionSavedApplications> createState() => _ImportInspectionSavedApplicationsState();
// }

// class _ImportInspectionSavedApplicationsState extends State<ImportInspectionSavedApplications> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("UAT-PQMS"),
//         backgroundColor: Colors.green[900],
//         actions: [
//           GestureDetector(
//             onTap: () {
//               Navigator.popUntil(
//                 context,
//                 ModalRoute.withName("/Dashboard"),
//               );
//             },
//             child: Icon(
//               Icons.home,
//               size: 50,
//               color: Colors.white,
//             ),
//           )
//         ],
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             fit: BoxFit.cover,
//             image: ExactAssetImage("assets/bg.png"),
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Container(
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Export Inspectiontion Details",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ),
//             ListData.isEmpty
//                 ? Expanded(
//                     flex: 18,
//                     child: Center(
//                       child: Text(
//                         "No Application Available",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   )
//                 : Expanded(
//                     flex: 18,
//                     child: ListView.builder(
//                       itemCount: ListData.length,
//                       itemBuilder: (context, index) {
//                         final data = ListData[index];
//                         return Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10.0),
//                             ),
//                           ),
//                           child: Column(
//                             children: [
//                               RowComponent(
//                                 "Application Id",
//                                 data.applicationId,
//                               ),
//                               RowComponent(
//                                 "Application Date",
//                                 data.inspectionDate,
//                               ),
//                               RowComponent(
//                                 "Duty Officer",
//                                 data.dutyofficer,
//                               ),
//                               RowComponent(
//                                 "No of Samples",
//                                 data.noofSamples,
//                               ),
//                               RowComponent(
//                                 "Remarks",
//                                 data.inspectionRemarks,
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   RowComponent(var data, var value) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 4, left: 10, bottom: 3),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               data.toString(),
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             child: Text(
//               value.toString(),
//               style: TextStyle(fontSize: 17),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }