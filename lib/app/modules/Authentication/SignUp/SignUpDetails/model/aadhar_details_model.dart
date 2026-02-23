class AadharDetailsModel {
  bool? success;
  String? message;
  AadharDetails? aadharDetails;

  AadharDetailsModel({this.success, this.message, this.aadharDetails});

  AadharDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    aadharDetails = json['aadharDetails'] != null
        ? AadharDetails.fromJson(json['aadharDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (aadharDetails != null) {
      data['aadharDetails'] = aadharDetails?.toJson();
    }
    return data;
  }
}

class AadharDetails {
  String? aadharNumber;
  String? name;
  String? dateOfBirth;
  String? address;
  String? status;
  String? gender;
  //String? photo;

  AadharDetails({
    this.aadharNumber,
    this.name,
    this.dateOfBirth,
    this.address,
    this.status,
    this.gender,
    // this.photo,
  });

  AadharDetails.fromJson(Map<String, dynamic> json) {
    aadharNumber = json['aadharNumber'];
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    address = json['address'];
    status = json['status'];
    gender = json['gender'];
    //photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aadharNumber'] = aadharNumber;
    data['name'] = name;
    data['dateOfBirth'] = dateOfBirth;
    data['address'] = address;
    data['status'] = status;
    data['gender'] = gender;
    //data['photo'] = this.photo;
    return data;
  }
}
