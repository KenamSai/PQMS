class ImportTreatmentSubmitModel {
  String? role;
  String? action;
  String? applicationId;
  String? chemicals;
  String? dosage;
  String? duration;
  String? temperature;
  String? treatmentDate;
  String? completedDateofSupervision;
  String? doneByAgency;
  String? remarks;
  String? employeeId;
  String? forwardToRole;

  ImportTreatmentSubmitModel(
      {this.role,
      this.action,
      this.applicationId,
      this.chemicals,
      this.dosage,
      this.duration,
      this.temperature,
      this.treatmentDate,
      this.completedDateofSupervision,
      this.doneByAgency,
      this.remarks,
      this.employeeId,
      this.forwardToRole});

  ImportTreatmentSubmitModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    action = json['action'];
    applicationId = json['applicationId'];
    chemicals = json['chemicals'];
    dosage = json['dosage'];
    duration = json['duration'];
    temperature = json['temperature'];
    treatmentDate = json['treatmentDate'];
    completedDateofSupervision = json['completedDateofSupervision'];
    doneByAgency = json['doneByAgency'];
    remarks = json['remarks'];
    employeeId = json['employeeId'];
    forwardToRole = json['forwardToRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['action'] = this.action;
    data['applicationId'] = this.applicationId;
    data['chemicals'] = this.chemicals;
    data['dosage'] = this.dosage;
    data['duration'] = this.duration;
    data['temperature'] = this.temperature;
    data['treatmentDate'] = this.treatmentDate;
    data['completedDateofSupervision'] = this.completedDateofSupervision;
    data['doneByAgency'] = this.doneByAgency;
    data['remarks'] = this.remarks;
    data['employeeId'] = this.employeeId;
    data['forwardToRole'] = this.forwardToRole;
    return data;
  }
}
