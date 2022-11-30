class ExportList_Model {
  String? statusMessage;
  int? statusCode;
  List<ExportData>? data;

  ExportList_Model({this.statusMessage, this.statusCode, this.data});

  ExportList_Model.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    statusCode = json['status_Code'];
    if (json['data'] != null) {
      data = <ExportData>[];
      json['data'].forEach((v) {
        data!.add(new ExportData.fromJson(v));
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

class ExportData {
  String? applicationId;
  String? exporterName;
  String? exporterCountry;
  String? exporterPurpose;
  String? applDate;
  String? commodity;
  String? status;

  ExportData(
      {this.applicationId,
      this.exporterName,
      this.exporterCountry,
      this.exporterPurpose,
      this.applDate,
      this.commodity,
      this.status});

  ExportData.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    exporterName = json['exporterName'];
    exporterCountry = json['exporterCountry'];
    exporterPurpose = json['exporterPurpose'];
    applDate = json['applDate'];
    commodity = json['commodity'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['exporterName'] = this.exporterName;
    data['exporterCountry'] = this.exporterCountry;
    data['exporterPurpose'] = this.exporterPurpose;
    data['applDate'] = this.applDate;
    data['commodity'] = this.commodity;
    data['status'] = this.status;
    return data;
  }
}