class LoginRequest {
  String? iMEI;
  String? deviceId;
  String? password;
  String? username;

  LoginRequest({this.iMEI, this.deviceId, this.password, this.username});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    iMEI = json['IMEI'];
    deviceId = json['deviceId'];
    password = json['password'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IMEI'] = this.iMEI;
    data['deviceId'] = this.deviceId;
    data['password'] = this.password;
    data['username'] = this.username;
    return data;
  }
}