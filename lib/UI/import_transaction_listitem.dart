import 'package:flutter/material.dart';
import 'package:pqms/ModelClass/transaction_response.dart';


class ImportTransactionListItem extends StatelessWidget {
  const ImportTransactionListItem({super.key, required this.userInfo});

  final TransactionData? userInfo;
  @override
  Widget build(BuildContext context) {
    return Card(
     margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          RowComponent("From User", userInfo?.fromUser?.username),
          RowComponent("To User", userInfo?.toUser?.username),
          RowComponent("Transaction Date", userInfo?.reportedDate),
          RowComponent("Comments", userInfo?.comments),
          RowComponent("Status", userInfo?.status),
        ],
      ),
    );
  }

  RowComponent(String data, String? value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value ?? ""))
        ],
      ),
    );
  }
}
