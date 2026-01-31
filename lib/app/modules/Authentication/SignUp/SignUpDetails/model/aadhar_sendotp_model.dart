class AadharSendOTPModel {
  bool? success;
  String? message;
  int? referenceId;

  AadharSendOTPModel({this.success, this.message, this.referenceId});

  AadharSendOTPModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    referenceId = json['referenceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['message'] = this.message;
    data['referenceId'] = this.referenceId;
    return data;
  }
}
