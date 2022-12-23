class ImportTreatmentModelClass {
  String? applicationId;
  String? Dutyofficer;
  int? DutyOfficerId;
  String? Chemicals;
  String? Dosage;
  String? Duration;
  String? Temperature;
  String? TreatmentDate;
  String? CompletedDate;
  String? DoneBy;
  int? agencyId;
  String? TreatmentRemarks;
  String? TreatmentLocation;
  String? TreatmentArea;
  

  ImportTreatmentModelClass(
      {this.applicationId,
      this.Dutyofficer,
      this.DutyOfficerId,
      this.Chemicals,
      this.Dosage,
      this.Duration,
      this.Temperature,
      this.TreatmentDate,
      this.CompletedDate,
      this.DoneBy,
      this.agencyId,
      this.TreatmentRemarks,
      this.TreatmentLocation,
      this.TreatmentArea, 
      });

  ImportTreatmentModelClass.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    Dutyofficer = json['Dutyofficer'];
    DutyOfficerId=json['DutyOfficerId'];
    Chemicals = json['Chemicals'];
    Dosage = json['Dosage'];
    Duration = json['Duration'];
    Temperature = json['Temperature'];
    TreatmentDate = json['TreatmentDate'];
    CompletedDate = json['CompletedDate'];
    DoneBy = json['DoneBy'];
    agencyId=json['agencyId'];
    TreatmentRemarks = json['TreatmentRemarks'];
    TreatmentLocation = json['TreatmentLocation'];
    TreatmentArea = json['TreatmentArea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['Dutyofficer'] = this.Dutyofficer;
    data['DutyOfficerId']=this.DutyOfficerId;
    data['Chemicals'] = this.Chemicals;
    data['Dosage'] = this.Dosage;
    data['Duration'] = this.Duration;
    data['Temperature'] = this.Temperature;
    data['TreatmentDate'] = this.TreatmentDate;
    data['CompletedDate'] = this.CompletedDate;
    data['TreatmentRemarks']=this.TreatmentRemarks;
    data['DoneBy'] = this.DoneBy;
    data['agencyId']=this.agencyId;
    data['TreatmentLocation'] = this.TreatmentLocation;
    data['TreatmentArea'] = this.TreatmentArea;
    return data;
  }
}
