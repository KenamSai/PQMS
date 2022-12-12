import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pqms/ModelClass/importModelClass.dart';
import 'package:pqms/routes/AppRoutes.dart';

class ImportListItem extends StatelessWidget {
  const ImportListItem({super.key, required this.userInfo});

  final Data? userInfo;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
         await EasyLoading.show(status: "Loading...");

        Navigator.pushNamed(
          context,
          AppRoutes.importApplDetails,
          arguments: userInfo?.applicationId,
        );
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
            RowComponent("Importer Name", userInfo?.importerName),
            RowComponent("Commodity", userInfo?.commodity),
            RowComponent("Status", userInfo?.status),
          ],
        ),
      ),
    );
  }

  RowComponent(String data, String? value) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
          child: SizedBox(
            width: 150,
            child: Text(
              data,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
          child: SizedBox(
            child: Text(value ?? ""),
          ),
        )
      ],
    );
  }
}
