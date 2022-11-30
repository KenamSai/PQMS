class ExportApplicationDetailsModelClass {
  String? statusMessage;
  int? statusCode;
  DataApplicationDetails? data;

  ExportApplicationDetailsModelClass({this.statusMessage, this.statusCode, this.data});

  ExportApplicationDetailsModelClass.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    statusCode = json['status_Code'];
    data = json['data'] != null ? new DataApplicationDetails.fromJson(json['data']) : null;
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

class DataApplicationDetails {
  int? id;
  String? applicationId;
  String? pqStation;
  String? importerName;
  String? exporterName;
  String? importerAddress;
  String? exporterAddress;
  String? commodity;
  String? scientificName;
  String? commodityDesc;
  String? plantPart;
  String? category;
  double? quantity;
  String? ieUser;
  String? units;
  double? quantityinVolume;
  int? noOfPackages;
  String? packingMode;
  String? countryOrigin;
  String? placeofOrigin;
  String? purposeofExport;
  int? noofContainers;
  String? distinguishMarks;
  String? countrytoExport;
  String? foreignportofShipment;
  String? portofLoading;
  String? meansOfConveyance;
  String? invoiceDate;
  String? placeofInspection;
  String? inspectionDate;
  String? invoiceNo;
  double? valueofCommodity;
  String? declaration;
  String? necessaryDocuments;
  bool? inspectionOutsidepqms;
  bool? treatmentNeeded;
  String? generatedDocument;
  String? consignmentId;
  String? shippingBillno;
  String? shippingBillDate;
  String? pscNo;
  String? date;
  String? attachFile;
  String? exportFormType;
  String? reportingYear;
  String? status;
  List<PscDocList>? pscDocList;

  DataApplicationDetails(
      {this.id,
      this.applicationId,
      this.pqStation,
      this.importerName,
      this.exporterName,
      this.importerAddress,
      this.exporterAddress,
      this.commodity,
      this.scientificName,
      this.commodityDesc,
      this.plantPart,
      this.category,
      this.quantity,
      this.ieUser,
      this.units,
      this.quantityinVolume,
      this.noOfPackages,
      this.packingMode,
      this.countryOrigin,
      this.placeofOrigin,
      this.purposeofExport,
      this.noofContainers,
      this.distinguishMarks,
      this.countrytoExport,
      this.foreignportofShipment,
      this.portofLoading,
      this.meansOfConveyance,
      this.invoiceDate,
      this.placeofInspection,
      this.inspectionDate,
      this.invoiceNo,
      this.valueofCommodity,
      this.declaration,
      this.necessaryDocuments,
      this.inspectionOutsidepqms,
      this.treatmentNeeded,
      this.generatedDocument,
      this.consignmentId,
      this.shippingBillno,
      this.shippingBillDate,
      this.pscNo,
      this.date,
      this.attachFile,
      this.exportFormType,
      this.reportingYear,
      this.status,
      this.pscDocList});

  DataApplicationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicationId = json['applicationId'];
    pqStation = json['pqStation'];
    importerName = json['importerName'];
    exporterName = json['exporterName'];
    importerAddress = json['importerAddress'];
    exporterAddress = json['exporterAddress'];
    commodity = json['commodity'];
    scientificName = json['scientificName'];
    commodityDesc = json['commodityDesc'];
    plantPart = json['plantPart'];
    category = json['category'];
    quantity = json['quantity'];
    ieUser = json['ieUser'];
    units = json['units'];
    quantityinVolume = json['quantityinVolume'];
    noOfPackages = json['noOfPackages'];
    packingMode = json['packingMode'];
    countryOrigin = json['countryOrigin'];
    placeofOrigin = json['placeofOrigin'];
    purposeofExport = json['purposeofExport'];
    noofContainers = json['noofContainers'];
    distinguishMarks = json['distinguishMarks'];
    countrytoExport = json['countrytoExport'];
    foreignportofShipment = json['foreignportofShipment'];
    portofLoading = json['portofLoading'];
    meansOfConveyance = json['meansOfConveyance'];
    invoiceDate = json['invoiceDate'];
    placeofInspection = json['placeofInspection'];
    inspectionDate = json['inspectionDate'];
    invoiceNo = json['invoiceNo'];
    valueofCommodity = json['valueofCommodity'];
    declaration = json['declaration'];
    necessaryDocuments = json['necessaryDocuments'];
    inspectionOutsidepqms = json['inspectionOutsidepqms'];
    treatmentNeeded = json['treatmentNeeded'];
    generatedDocument = json['generatedDocument'];
    consignmentId = json['consignmentId'];
    shippingBillno = json['shippingBillno'];
    shippingBillDate = json['shippingBillDate'];
    pscNo = json['pscNo'];
    date = json['date'];
    attachFile = json['attachFile'];
    exportFormType = json['exportFormType'];
    reportingYear = json['reportingYear'];
    status = json['status'];
    if (json['pscDocList'] != null) {
      pscDocList = <PscDocList>[];
      json['pscDocList'].forEach((v) {
        pscDocList!.add(new PscDocList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applicationId'] = this.applicationId;
    data['pqStation'] = this.pqStation;
    data['importerName'] = this.importerName;
    data['exporterName'] = this.exporterName;
    data['importerAddress'] = this.importerAddress;
    data['exporterAddress'] = this.exporterAddress;
    data['commodity'] = this.commodity;
    data['scientificName'] = this.scientificName;
    data['commodityDesc'] = this.commodityDesc;
    data['plantPart'] = this.plantPart;
    data['category'] = this.category;
    data['quantity'] = this.quantity;
    data['ieUser'] = this.ieUser;
    data['units'] = this.units;
    data['quantityinVolume'] = this.quantityinVolume;
    data['noOfPackages'] = this.noOfPackages;
    data['packingMode'] = this.packingMode;
    data['countryOrigin'] = this.countryOrigin;
    data['placeofOrigin'] = this.placeofOrigin;
    data['purposeofExport'] = this.purposeofExport;
    data['noofContainers'] = this.noofContainers;
    data['distinguishMarks'] = this.distinguishMarks;
    data['countrytoExport'] = this.countrytoExport;
    data['foreignportofShipment'] = this.foreignportofShipment;
    data['portofLoading'] = this.portofLoading;
    data['meansOfConveyance'] = this.meansOfConveyance;
    data['invoiceDate'] = this.invoiceDate;
    data['placeofInspection'] = this.placeofInspection;
    data['inspectionDate'] = this.inspectionDate;
    data['invoiceNo'] = this.invoiceNo;
    data['valueofCommodity'] = this.valueofCommodity;
    data['declaration'] = this.declaration;
    data['necessaryDocuments'] = this.necessaryDocuments;
    data['inspectionOutsidepqms'] = this.inspectionOutsidepqms;
    data['treatmentNeeded'] = this.treatmentNeeded;
    data['generatedDocument'] = this.generatedDocument;
    data['consignmentId'] = this.consignmentId;
    data['shippingBillno'] = this.shippingBillno;
    data['shippingBillDate'] = this.shippingBillDate;
    data['pscNo'] = this.pscNo;
    data['date'] = this.date;
    data['attachFile'] = this.attachFile;
    data['exportFormType'] = this.exportFormType;
    data['reportingYear'] = this.reportingYear;
    data['status'] = this.status;
    if (this.pscDocList != null) {
      data['pscDocList'] = this.pscDocList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PscDocList {
  String? document;

  PscDocList({this.document});

  PscDocList.fromJson(Map<String, dynamic> json) {
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document'] = this.document;
    return data;
  }
}
