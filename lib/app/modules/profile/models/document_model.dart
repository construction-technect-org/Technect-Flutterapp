import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';

class DeleteDocumentResponse {
  bool? success;
  String? message;
  DeleteDocumentData? data;

  DeleteDocumentResponse({this.success, this.message, this.data});

  factory DeleteDocumentResponse.fromJson(Map<String, dynamic> json) =>
      DeleteDocumentResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DeleteDocumentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class DeleteDocumentData {
  Documents? deletedDocument;
  int? profileCompletionPercentage;
  bool? isProfileComplete;
  VerificationStatus? verificationStatus;

  DeleteDocumentData({
    this.deletedDocument,
    this.profileCompletionPercentage,
    this.isProfileComplete,
    this.verificationStatus,
  });

  factory DeleteDocumentData.fromJson(Map<String, dynamic> json) =>
      DeleteDocumentData(
        deletedDocument: json["deleted_document"] == null
            ? null
            : Documents.fromJson(json["deleted_document"]),
        profileCompletionPercentage: json["profile_completion_percentage"],
        isProfileComplete: json["is_profile_complete"],
        verificationStatus: json["verification_status"] == null
            ? null
            : VerificationStatus.fromJson(json["verification_status"]),
      );

  Map<String, dynamic> toJson() => {
    "deleted_document": deletedDocument?.toJson(),
    "profile_completion_percentage": profileCompletionPercentage,
    "is_profile_complete": isProfileComplete,
    "verification_status": verificationStatus?.toJson(),
  };
}
