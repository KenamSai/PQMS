class finalInspectionSubmitModelClass {
  String? role;
  String? applicationId;
  String? noOfSamples;
  String? sampleSize;
  String? inspectionPlace;
  String? inspectionDate;
  String? remarks;
  String? action;
  String? employeeId;
  String? forwardToRole;
  String? inptLocation;
  String? deviceId;
  String? inspctArea;
  String? inptDoc1;
  String? inptDoc2;
  String? inptDoc3;

  finalInspectionSubmitModelClass(
      {this.role,
      this.applicationId,
      this.noOfSamples,
      this.sampleSize,
      this.inspectionPlace,
      this.inspectionDate,
      this.remarks,
      this.action,
      this.employeeId,
      this.forwardToRole,
      this.inptLocation,
      this.deviceId,
      this.inspctArea,
      this.inptDoc1,
      this.inptDoc2,
      this.inptDoc3});

  finalInspectionSubmitModelClass.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    applicationId = json['applicationId'];
    noOfSamples = json['noOfSamples'];
    sampleSize = json['sampleSize'];
    inspectionPlace = json['inspectionPlace'];
    inspectionDate = json['inspectionDate'];
    remarks = json['remarks'];
    action = json['action'];
    employeeId = json['employeeId'];
    forwardToRole = json['forwardToRole'];
    inptLocation = json['inptLocation'];
    deviceId = json['deviceId'];
    inspctArea = json['inspctArea'];
    inptDoc1 = json['inptDoc1'];
    inptDoc2 = json['inptDoc2'];
    inptDoc3 = json['inptDoc3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['applicationId'] = this.applicationId;
    data['noOfSamples'] = this.noOfSamples;
    data['sampleSize'] = this.sampleSize;
    data['inspectionPlace'] = this.inspectionPlace;
    data['inspectionDate'] = this.inspectionDate;
    data['remarks'] = this.remarks;
    data['action'] = this.action;
    data['employeeId'] = this.employeeId;
    data['forwardToRole'] = this.forwardToRole;
    data['inptLocation'] = this.inptLocation;
    data['deviceId'] = this.deviceId;
    data['inspctArea'] = this.inspctArea;
    data['inptDoc1'] = this.inptDoc1;
    data['inptDoc2'] = this.inptDoc2;
    data['inptDoc3'] = this.inptDoc3;
    return data;
  }
}
