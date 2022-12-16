class ImportResponseinspectionModelClass {
  String? applicationId;
  String? Dutyofficer;
  String? NoofSamples;
  String? SampleSize;
  String? InspectionPlace;
  String? InspectionDate;
  String? InspectionRemarks;
  String? inptLocation;
  String? inspctArea;
  String? userimage1;
  String? userimage2;
  String? userimage3;

  ImportResponseinspectionModelClass(
      {this.applicationId,
      this.Dutyofficer,
      this.NoofSamples,
      this.SampleSize,
      this.InspectionPlace,
      this.InspectionDate,
      this.InspectionRemarks,
      this.inptLocation,
      this.inspctArea,
      this.userimage1,
      this.userimage2,
      this.userimage3});

  ImportResponseinspectionModelClass.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    Dutyofficer = json['Dutyofficer'];
    NoofSamples = json['NoofSamples'];
    SampleSize = json['SampleSize'];
    InspectionPlace = json['InspectionPlace'];
    InspectionDate = json['InspectionDate'];
    InspectionRemarks = json['InspectionRemarks'];
    inptLocation=json['inptLocation'];
    inspctArea=json['inspctArea'];
    userimage1 = json['userimage1'];
    userimage2 = json['userimage2'];
    userimage3 = json['userimage3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['Dutyofficer'] = this.Dutyofficer;
    data['NoofSamples'] = this.NoofSamples;
    data['SampleSize'] = this.SampleSize;
    data['InspectionPlace'] = this.InspectionPlace;
    data['InspectionDate'] = this.InspectionDate;
    data['InspectionRemarks'] = this.InspectionRemarks;
    data['inptLocation']=this.inptLocation;
    data['inspctArea']=this.inspctArea;
    data['userimage1'] = this.userimage1;
    data['userimage2'] = this.userimage2;
    data['userimage3'] = this.userimage3;
    return data;
  }
}
