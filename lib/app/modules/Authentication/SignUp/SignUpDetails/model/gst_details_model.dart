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
    data['success'] = this.success;
    if (this.gstDetails != null) {
      data['gstDetails'] = this.gstDetails?.toJson();
    }
    data['message'] = this.message;
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
    data['gstNumber'] = this.gstNumber;
    data['legalName'] = this.legalName;
    data['tradeName'] = this.tradeName;
    data['address'] = this.address;
    data['registrationDate'] = this.registrationDate;
    data['status'] = this.status;
    data['businessType'] = this.businessType;
    data['centerJurisdiction'] = this.centerJurisdiction;
    data['stateJurisdiction'] = this.stateJurisdiction;
    return data;
  }
}
