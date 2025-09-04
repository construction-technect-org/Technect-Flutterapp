class ErrorModel {
  bool? success;
  String? message;
  String? code;

  ErrorModel({this.success, this.message, this.code});

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      ErrorModel(success: json["success"], message: json["message"], code: json["code"]);

  Map<String, dynamic> toJson() => {"success": success, "message": message, "code": code};
}
