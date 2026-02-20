class ErrorModel {
  bool? success;
  String? message;
  String? code;

  ErrorModel({this.success, this.message, this.code});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    // Server may return message as a String or a List<String> (validation errors)
    final rawMessage = json["message"];
    String? message;
    if (rawMessage is List) {
      message = rawMessage.join('; ');
    } else {
      message = rawMessage as String?;
    }
    return ErrorModel(success: json["success"], message: message, code: json["code"]);
  }

  Map<String, dynamic> toJson() => {"success": success, "message": message, "code": code};
}
