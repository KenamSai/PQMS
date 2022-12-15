class DonebyModelClass {
  int? statusCode;
  List<DataAgencyList>? data;

  DonebyModelClass({this.statusCode, this.data});

  DonebyModelClass.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_Code'];
    if (json['data'] != null) {
      data = <DataAgencyList>[];
      json['data'].forEach((v) {
        data!.add(new DataAgencyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataAgencyList {
  int? id;
  String? fumigationAgent;
  int? agentType;
  String? registrationNumber;
  bool? isActive;
  String? address;
  String? contactNo;
  String? fromDate;
  String? toDate;


  DataAgencyList(
      {this.id,
      this.fumigationAgent,
      this.agentType,
      this.registrationNumber,
      this.isActive,
      this.address,
      this.contactNo,
      this.fromDate,
      this.toDate});

  DataAgencyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fumigationAgent = json['fumigationAgent'];
    agentType = json['agentType'];
    registrationNumber = json['registrationNumber'];
    isActive = json['isActive'];
    address = json['address'];
    contactNo = json['contactNo'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fumigationAgent'] = this.fumigationAgent;
    data['agentType'] = this.agentType;
    data['registrationNumber'] = this.registrationNumber;
    data['isActive'] = this.isActive;
    data['address'] = this.address;
    data['contactNo'] = this.contactNo;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    return data;
  }
}
