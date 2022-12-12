class ImportInspectionSubmitModel {
  String? quantityfound;
  String? inspectionPlace;
  String? noOfSamples;
  String? action;
  String? applicationId;
  String? role;
  String? remarks;
  String? employeeId;
  String? forwardToRole;
  String? inspectionDate;
  String? sampleSize;
  String? inptLocation;
  String? deviceId;
  String? inspctArea;
  String? inptDoc1;
  String? inptDoc2;
  String? inptDoc3;

  ImportInspectionSubmitModel(
      {this.quantityfound,
      this.inspectionPlace,
      this.noOfSamples,
      this.action,
      this.applicationId,
      this.role,
      this.remarks,
      this.employeeId,
      this.forwardToRole,
      this.inspectionDate,
      this.sampleSize,
      this.inptLocation,
      this.deviceId,
      this.inspctArea,
      this.inptDoc1,
      this.inptDoc2,
      this.inptDoc3});

  ImportInspectionSubmitModel.fromJson(Map<String, dynamic> json) {
    quantityfound = json['quantityfound'];
    inspectionPlace = json['inspectionPlace'];
    noOfSamples = json['noOfSamples'];
    action = json['action'];
    applicationId = json['applicationId'];
    role = json['role'];
    remarks = json['remarks'];
    employeeId = json['employeeId'];
    forwardToRole = json['forwardToRole'];
    inspectionDate = json['inspectionDate'];
    sampleSize = json['sampleSize'];
    inptLocation = json['inptLocation'];
    deviceId = json['deviceId'];
    inspctArea = json['inspctArea'];
    inptDoc1 = json['inptDoc1'];
    inptDoc2 = json['inptDoc2'];
    inptDoc3 = json['inptDoc3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantityfound'] = this.quantityfound;
    data['inspectionPlace'] = this.inspectionPlace;
    data['noOfSamples'] = this.noOfSamples;
    data['action'] = this.action;
    data['applicationId'] = this.applicationId;
    data['role'] = this.role;
    data['remarks'] = this.remarks;
    data['employeeId'] = this.employeeId;
    data['forwardToRole'] = this.forwardToRole;
    data['inspectionDate'] = this.inspectionDate;
    data['sampleSize'] = this.sampleSize;
    data['inptLocation'] = this.inptLocation;
    data['deviceId'] = this.deviceId;
    data['inspctArea'] = this.inspctArea;
    data['inptDoc1'] = this.inptDoc1;
    data['inptDoc2'] = this.inptDoc2;
    data['inptDoc3'] = this.inptDoc3;
    return data;
  }
}
