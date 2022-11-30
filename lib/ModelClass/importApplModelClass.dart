class importApplDetailsModelClass {
  String? statusMessage;
  int? statusCode;
  DataDetails? data;

  importApplDetailsModelClass({this.statusMessage, this.statusCode, this.data});

  importApplDetailsModelClass.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    statusCode = json['status_Code'];
    data = json['data'] != null ? new DataDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['status_Code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataDetails {
  int? id;
  String? applicationId;
  String? applDate;
  String? appliedFor;
  String? appType;
  String? category;
  String? commodity;
  String? pqStation;
  String? countryOrigin;
  String? countryReExport;
  String? exporterAddress;
  String? exporterName;
  String? importerName;
  String? foreignPortShipment;
  String? ieUser;
  String? importPurpose;
  String? importerAddress;
  String? meansOfConveyance;
  String? packingMode;
  String? plantPart;
  String? pointOfEntry;
  double? quantity;
  String? scientificName;
  String? units;
  String? dateOfArrival;
  String? importDocName;
  String? beAttach;
  String? status;
  int? noOfPackages;
  String? formType;
  String? nameOfLocationOfPostEntry;
  String? variety;
  String? noOfSpecimens;
  String? distinguishingMarks;
  String? vessalName;
  String? bENo;
  String? bEDate;
  String? inspectionPlace;
  String? inspectionDate;
  String? pscNo;
  String? pscDate;
  double? commodityValue;
  String? partshipment;
  String? importpermitno;
  String? necessarydocuments;
  String? generatedDocument;
  String? reportingYear;
  bool? treatmentNeeded;
  List<IroDocList>? iroDocList;

  DataDetails(
      {this.id,
      this.applicationId,
      this.applDate,
      this.appliedFor,
      this.appType,
      this.category,
      this.commodity,
      this.pqStation,
      this.countryOrigin,
      this.countryReExport,
      this.exporterAddress,
      this.exporterName,
      this.importerName,
      this.foreignPortShipment,
      this.ieUser,
      this.importPurpose,
      this.importerAddress,
      this.meansOfConveyance,
      this.packingMode,
      this.plantPart,
      this.pointOfEntry,
      this.quantity,
      this.scientificName,
      this.units,
      this.dateOfArrival,
      this.importDocName,
      this.beAttach,
      this.status,
      this.noOfPackages,
      this.formType,
      this.nameOfLocationOfPostEntry,
      this.variety,
      this.noOfSpecimens,
      this.distinguishingMarks,
      this.vessalName,
      this.bENo,
      this.bEDate,
      this.inspectionPlace,
      this.inspectionDate,
      this.pscNo,
      this.pscDate,
      this.commodityValue,
      this.partshipment,
      this.importpermitno,
      this.necessarydocuments,
      this.generatedDocument,
      this.reportingYear,
      this.treatmentNeeded,
      this.iroDocList});

  DataDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicationId = json['applicationId'];
    applDate = json['applDate'];
    appliedFor = json['appliedFor'];
    appType = json['appType'];
    category = json['category'];
    commodity = json['commodity'];
    pqStation = json['pqStation'];
    countryOrigin = json['countryOrigin'];
    countryReExport = json['countryReExport'];
    exporterAddress = json['exporterAddress'];
    exporterName = json['exporterName'];
    importerName = json['importerName'];
    foreignPortShipment = json['foreignPortShipment'];
    ieUser = json['ieUser'];
    importPurpose = json['importPurpose'];
    importerAddress = json['importerAddress'];
    meansOfConveyance = json['meansOfConveyance'];
    packingMode = json['packingMode'];
    plantPart = json['plantPart'];
    pointOfEntry = json['pointOfEntry'];
    quantity = json['quantity'];
    scientificName = json['scientificName'];
    units = json['units'];
    dateOfArrival = json['dateOfArrival'];
    importDocName = json['importDocName'];
    beAttach = json['beAttach'];
    status = json['status'];
    noOfPackages = json['noOfPackages'];
    formType = json['formType'];
    nameOfLocationOfPostEntry = json['nameOfLocationOfPostEntry'];
    variety = json['variety'];
    noOfSpecimens = json['noOfSpecimens'];
    distinguishingMarks = json['distinguishingMarks'];
    vessalName = json['vessalName'];
    bENo = json['bENo'];
    bEDate = json['bEDate'];
    inspectionPlace = json['inspectionPlace'];
    inspectionDate = json['inspectionDate'];
    pscNo = json['pscNo'];
    pscDate = json['pscDate'];
    commodityValue = json['commodityValue'];
    partshipment = json['partshipment'];
    importpermitno = json['importpermitno'];
    necessarydocuments = json['necessarydocuments'];
    generatedDocument = json['generatedDocument'];
    reportingYear = json['reportingYear'];
    treatmentNeeded = json['treatmentNeeded'];
    if (json['iroDocList'] != null) {
      iroDocList = <IroDocList>[];
      json['iroDocList'].forEach((v) {
        iroDocList!.add(new IroDocList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applicationId'] = this.applicationId;
    data['applDate'] = this.applDate;
    data['appliedFor'] = this.appliedFor;
    data['appType'] = this.appType;
    data['category'] = this.category;
    data['commodity'] = this.commodity;
    data['pqStation'] = this.pqStation;
    data['countryOrigin'] = this.countryOrigin;
    data['countryReExport'] = this.countryReExport;
    data['exporterAddress'] = this.exporterAddress;
    data['exporterName'] = this.exporterName;
    data['importerName'] = this.importerName;
    data['foreignPortShipment'] = this.foreignPortShipment;
    data['ieUser'] = this.ieUser;
    data['importPurpose'] = this.importPurpose;
    data['importerAddress'] = this.importerAddress;
    data['meansOfConveyance'] = this.meansOfConveyance;
    data['packingMode'] = this.packingMode;
    data['plantPart'] = this.plantPart;
    data['pointOfEntry'] = this.pointOfEntry;
    data['quantity'] = this.quantity;
    data['scientificName'] = this.scientificName;
    data['units'] = this.units;
    data['dateOfArrival'] = this.dateOfArrival;
    data['importDocName'] = this.importDocName;
    data['beAttach'] = this.beAttach;
    data['status'] = this.status;
    data['noOfPackages'] = this.noOfPackages;
    data['formType'] = this.formType;
    data['nameOfLocationOfPostEntry'] = this.nameOfLocationOfPostEntry;
    data['variety'] = this.variety;
    data['noOfSpecimens'] = this.noOfSpecimens;
    data['distinguishingMarks'] = this.distinguishingMarks;
    data['vessalName'] = this.vessalName;
    data['bENo'] = this.bENo;
    data['bEDate'] = this.bEDate;
    data['inspectionPlace'] = this.inspectionPlace;
    data['inspectionDate'] = this.inspectionDate;
    data['pscNo'] = this.pscNo;
    data['pscDate'] = this.pscDate;
    data['commodityValue'] = this.commodityValue;
    data['partshipment'] = this.partshipment;
    data['importpermitno'] = this.importpermitno;
    data['necessarydocuments'] = this.necessarydocuments;
    data['generatedDocument'] = this.generatedDocument;
    data['reportingYear'] = this.reportingYear;
    data['treatmentNeeded'] = this.treatmentNeeded;
    if (this.iroDocList != null) {
      data['iroDocList'] = this.iroDocList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IroDocList {
  String? document;

  IroDocList({this.document});

  IroDocList.fromJson(Map<String, dynamic> json) {
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document'] = this.document;
    return data;
  }
}
