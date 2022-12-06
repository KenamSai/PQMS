class TransactionResponse {
  String? statusMessage;
  int? statusCode;
  List<TransactionData>? data;
  String? time;

  TransactionResponse(
      {this.statusMessage, this.statusCode, this.data, this.time});

  TransactionResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    statusCode = json['status_Code'];
    if (json['data'] != null) {
      data = <TransactionData>[];
      json['data'].forEach((v) {
        data!.add(new TransactionData.fromJson(v));
      });
    }
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['status_Code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['time'] = this.time;
    return data;
  }
}

class TransactionData {
  int? id;
  String? applicationId;
  FromUser? fromUser;
  FromUser? toUser;
  String? comments;
  String? status;
  String? reportedDate;

  TransactionData(
      {this.id,
      this.applicationId,
      this.fromUser,
      this.toUser,
      this.comments,
      this.status,
      this.reportedDate});

  TransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicationId = json['applicationId'];
    fromUser = json['fromUser'] != null
        ? new FromUser.fromJson(json['fromUser'])
        : null;
    toUser =
        json['toUser'] != null ? new FromUser.fromJson(json['toUser']) : null;
    comments = json['comments'];
    status = json['status'];
    reportedDate = json['reportedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applicationId'] = this.applicationId;
    if (this.fromUser != null) {
      data['fromUser'] = this.fromUser!.toJson();
    }
    if (this.toUser != null) {
      data['toUser'] = this.toUser!.toJson();
    }
    data['comments'] = this.comments;
    data['status'] = this.status;
    data['reportedDate'] = this.reportedDate;
    return data;
  }
}

class FromUser {
  int? id;
  String? username;
  String? password;
  bool? activated;

  FromUser({this.id, this.username, this.password, this.activated});

  FromUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    activated = json['activated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['activated'] = this.activated;
    return data;
  }
}
