class ImportTreatmentModelClass {
  String? applicationId;
  String? Dutyofficer;
  String? Chemicals;
  String? Dosage;
  String? Duration;
  String? Temperature;
  String? TreatmentDate;
  String? CompletedDate;
  String? DoneBy;
  String? TreatmentRemarks;
  

  ImportTreatmentModelClass(
      {this.applicationId,
      this.Dutyofficer,
      this.Chemicals,
      this.Dosage,
      this.Duration,
      this.Temperature,
      this.TreatmentDate,
      this.CompletedDate,
      this.DoneBy,
      this.TreatmentRemarks});

  ImportTreatmentModelClass.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    Dutyofficer = json['Dutyofficer'];
    Chemicals = json['Chemicals'];
    Dosage = json['Dosage'];
    Duration = json['Duration'];
    Temperature = json['Temperature'];
    TreatmentDate = json['TreatmentDate'];
    CompletedDate = json['CompletedDate'];
    DoneBy = json['DoneBy'];
    TreatmentRemarks = json['TreatmentRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['Dutyofficer'] = this.Dutyofficer;
    data['Chemicals'] = this.Chemicals;
    data['Dosage'] = this.Dosage;
    data['Duration'] = this.Duration;
    data['Temperature'] = this.Temperature;
    data['TreatmentDate'] = this.TreatmentDate;
    data['CompletedDate'] = this.CompletedDate;
    data['DoneBy'] = this.DoneBy;
    data['TreatmentRemarks'] = this.TreatmentRemarks;
    return data;
  }
}
