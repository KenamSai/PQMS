import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/DutyOfficersResponse.dart';
import 'package:pqms/db/DatabaseHelper.dart';

class RetrieveDutyOfficersData extends StatefulWidget {
  const RetrieveDutyOfficersData({super.key});

  @override
  State<RetrieveDutyOfficersData> createState() =>
      _RetrieveDutyOfficersDataState();
}

class _RetrieveDutyOfficersDataState extends State<RetrieveDutyOfficersData> {
  List<DutyOfficersResponse> userData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (context, index) {
          final data = userData[index];
          
          return ListTile(
            title: Text("${data.name}   ${data.userId}"),
          );
        },
      )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.instance.queryAllRows("DutyOfficers").then((value) {
      setState(() {
        value.forEach((element) {
          userData.add(
            DutyOfficersResponse(
                name: element["Name"], userId: element["UserId"]),
          );
          print(userData);
        });
      });
    }).catchError((error) {
      print(error);
    });
  }
}
