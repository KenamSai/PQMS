class DutyOfficersResponse {
  int? userId;
  String? name;

  DutyOfficersResponse({this.userId, this.name});

  DutyOfficersResponse.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['Name'] = this.name;
    return data;
  }
}
