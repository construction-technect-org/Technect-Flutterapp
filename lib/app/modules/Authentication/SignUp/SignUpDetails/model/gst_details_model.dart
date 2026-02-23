class DetailsGST {
  bool? success;
  GstDetails? gstDetails;
  String? message;

  DetailsGST({this.success, this.gstDetails, this.message});

  DetailsGST.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    gstDetails = json['gstDetails'] != null
        ? GstDetails.fromJson(json['gstDetails'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (gstDetails != null) {
      data['gstDetails'] = gstDetails?.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class GstDetails {
  String? gstNumber;
  String? legalName;
  String? tradeName;
  String? address;
  String? registrationDate;
  String? status;
  String? businessType;
  String? centerJurisdiction;
  String? stateJurisdiction;

  GstDetails({
    this.gstNumber,
    this.legalName,
    this.tradeName,
    this.address,
    this.registrationDate,
    this.status,
    this.businessType,
    this.centerJurisdiction,
    this.stateJurisdiction,
  });

  GstDetails.fromJson(Map<String, dynamic> json) {
    gstNumber = json['gstNumber'];
    legalName = json['legalName'];
    tradeName = json['tradeName'];
    address = json['address'];
    registrationDate = json['registrationDate'];
    status = json['status'];
    businessType = json['businessType'];
    centerJurisdiction = json['centerJurisdiction'];
    stateJurisdiction = json['stateJurisdiction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gstNumber'] = gstNumber;
    data['legalName'] = legalName;
    data['tradeName'] = tradeName;
    data['address'] = address;
    data['registrationDate'] = registrationDate;
    data['status'] = status;
    data['businessType'] = businessType;
    data['centerJurisdiction'] = centerJurisdiction;
    data['stateJurisdiction'] = stateJurisdiction;
    return data;
  }
}
