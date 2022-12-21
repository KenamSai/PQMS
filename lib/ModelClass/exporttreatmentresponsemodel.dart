class exporttreatmentresponsemodelclass {
  String? applicationId;
  String? dutyofficer;
  int? dutyofficerId;
  String? chemicals;
  String? dosage;
  String? durationHrs;
  String? temperatureDegC;
  String? treatmentDate;
  String? completionDate;
  String? doneby;
  String? treatmentRemarks;
  int? agencyId;

  exporttreatmentresponsemodelclass({
    this.applicationId,
    this.dutyofficer,
    this.chemicals,
    this.dosage,
    this.durationHrs,
    this.temperatureDegC,
    this.treatmentDate,
    this.completionDate,
    this.doneby,
    this.treatmentRemarks,
    this.dutyofficerId,
    this.agencyId
  });

  exporttreatmentresponsemodelclass.fromJson(Map<String, dynamic> json) {
    dutyofficerId=json["DutyOfficerId"];
    applicationId = json['applicationId'];
    dutyofficer = json['Dutyofficer'];
    chemicals = json['Chemicals'];
    dosage = json['Dosage'];
    durationHrs = json['Duration'];
    temperatureDegC = json['Temperature'];
    treatmentDate = json['TreatmentDate'];
    completionDate = json['CompletionDate'];
    doneby = json['Doneby'];
    treatmentRemarks = json['TreatmentRemarks'];
    agencyId=json["AgencyId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["DutyOfficerId"]=this.dutyofficerId;
    data['applicationId'] = this.applicationId;
    data['Dutyofficer'] = this.dutyofficer;
    data['Chemicals'] = this.chemicals;
    data['Dosage'] = this.dosage;
    data['Duration'] = this.durationHrs;
    data['Temperature'] = this.temperatureDegC;
    data['TreatmentDate'] = this.treatmentDate;
    data['CompletionDate'] = this.completionDate;
    data['Doneby'] = this.doneby;
    data['TreatmentRemarks'] = this.treatmentRemarks;
    data["AgencyId"]=this.agencyId;
    return data;
  }
}
