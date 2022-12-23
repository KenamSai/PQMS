class exportResponseinspectionModelClass {
  String? applicationId;
  String? dutyofficer;
  int? dutyofficerId;
  String? noofSamples;
  String? sampleSize;
  String? inspectionPlace;
  String? inspectionDate;
  String? inspectionRemarks;
  String? inspctArea;
  String? inspctLocation;
  String? userimage1;
  String? userimage2;
  String? userimage3;

  exportResponseinspectionModelClass({
    this.applicationId,
    this.dutyofficer,
    this.dutyofficerId,
    this.noofSamples,
    this.sampleSize,
    this.inspectionPlace,
    this.inspectionDate,
    this.inspectionRemarks,
    this.userimage1,
    this.userimage2,
    this.userimage3,
    this.inspctArea,
    this.inspctLocation,
  });

  exportResponseinspectionModelClass.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    dutyofficer = json['Dutyofficer'];
    noofSamples = json['NoofSamples'];
    sampleSize = json['SampleSize'];
    inspectionPlace = json['InspectionPlace'];
    inspectionDate = json['InspectionDate'];
    inspectionRemarks = json['InspectionRemarks'];
    userimage1 = json['userimage1'];
    userimage2 = json['userimage2'];
    userimage3 = json['userimage3'];
    dutyofficerId = json["DutyOfficerId"];
    inspctArea=json["inspctArea"];
    inspctLocation=json["inptLocation"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['Dutyofficer'] = this.dutyofficer;
    data['NoofSamples'] = this.noofSamples;
    data['SampleSize'] = this.sampleSize;
    data['InspectionPlace'] = this.inspectionPlace;
    data['InspectionDate'] = this.inspectionDate;
    data['InspectionRemarks'] = this.inspectionRemarks;
    data['userimage1'] = this.userimage1;
    data['userimage2'] = this.userimage2;
    data['userimage3'] = this.userimage3;
    data["DutyOfficerId"] = this.dutyofficerId;
    data["inptLocation"]=this.inspctLocation;
    data["inspctArea"]=this.inspctArea;
    return data;
  }
}
