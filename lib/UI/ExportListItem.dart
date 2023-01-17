import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/ModelClass/exportListModel.dart';
import 'package:pqms/routes/AppRoutes.dart';

class ExportListItem extends StatelessWidget {
  const ExportListItem({super.key, required this.userInfo});

  final ExportData? userInfo;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
         FocusScope.of(context).unfocus();
         await EasyLoading.show(status: "Loading...");
         Navigator.pushNamed(context, AppRoutes.exportApplnDetails,
            arguments: userInfo?.applicationId);
      },
      child: Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            RowComponent("Application Id", userInfo?.applicationId),
            RowComponent("Application Date", userInfo?.applDate),
            RowComponent("Importer Name", userInfo?.exporterName),
            RowComponent("Commodity", userInfo?.commodity),
            RowComponent("Status", userInfo?.status),
          ],
        ),
      ),
    );
  }

  RowComponent(String data, String? value) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Row(
        children: [

           Expanded(
              child: Text(
                data.toString(),
                style: TextStyle(fontWeight: FontWeight.bold,) //fontSize: 17
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                value.toString(),
               // style: TextStyle(fontSize: 17),
              ),
            )
          
        ],
      ),
    );
  }
}
