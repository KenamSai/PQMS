class importModelClass {
  String? statusMessage;
  int? statusCode;
  List<Data>? data;

  importModelClass({this.statusMessage, this.statusCode, this.data});

  importModelClass.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    statusCode = json['status_Code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['status_Code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? applicationId;
  String? importerName;
  String? applDate;
  String? commodity;
  String? status;
  String? formType;

  Data(
      {this.applicationId,
      this.importerName,
      this.applDate,
      this.commodity,
      this.status,
      this.formType});

  Data.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    importerName = json['importerName'];
    applDate = json['applDate'];
    commodity = json['commodity'];
    status = json['status'];
    formType = json['formType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['importerName'] = this.importerName;
    data['applDate'] = this.applDate;
    data['commodity'] = this.commodity;
    data['status'] = this.status;
    data['formType'] = this.formType;
    return data;
  }
}
