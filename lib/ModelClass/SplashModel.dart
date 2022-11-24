class SplashModelClass {
  String? statusMessage;
  int? statusCode;
  Data? data;

  SplashModelClass({this.statusMessage, this.statusCode, this.data});

  SplashModelClass.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    statusCode = json['status_Code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['status_Code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? versionNumber;
  String? versionDate;
  String? statusMessage;
  bool? isActive;
  String? osType;
  bool? accountDeleteFlog;

  Data(
      {this.id,
      this.versionNumber,
      this.versionDate,
      this.statusMessage,
      this.isActive,
      this.osType,
      this.accountDeleteFlog});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    versionNumber = json['versionNumber'];
    versionDate = json['versionDate'];
    statusMessage = json['statusMessage'];
    isActive = json['isActive'];
    osType = json['osType'];
    accountDeleteFlog = json['accountDeleteFlog'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['versionNumber'] = this.versionNumber;
    data['versionDate'] = this.versionDate;
    data['statusMessage'] = this.statusMessage;
    data['isActive'] = this.isActive;
    data['osType'] = this.osType;
    data['accountDeleteFlog'] = this.accountDeleteFlog;
    return data;
  }
}
