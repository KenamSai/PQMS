class DonebyModelResponseTreatment {
  String? fumigationAgent;
  int? id;

  DonebyModelResponseTreatment({this.fumigationAgent, this.id});

  DonebyModelResponseTreatment.fromJson(Map<String, dynamic> json) {
    fumigationAgent = json['fumigationAgent'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fumigationAgent'] = this.fumigationAgent;
    data['id'] = this.id;
    return data;
  }
}
