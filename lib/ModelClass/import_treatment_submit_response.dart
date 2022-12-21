class ImportTreatmentSubmitResponse {
  String? statusMessage;
  int? statusCode;

  ImportTreatmentSubmitResponse({this.statusMessage, this.statusCode});

  ImportTreatmentSubmitResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    statusCode = json['status_Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['status_Code'] = this.statusCode;
    return data;
  }
}
