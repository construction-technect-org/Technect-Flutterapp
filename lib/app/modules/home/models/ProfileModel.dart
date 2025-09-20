import 'package:construction_technect/app/modules/login/models/UserModel.dart';

class ProfileModel {
  bool? success;
  Data? data;

  ProfileModel({this.success, this.data});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class Data {
  UserModel? user;
  MerchantProfile? merchantProfile;

  Data({this.user, this.merchantProfile});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
    merchantProfile: json["merchantProfile"] == null
        ? null
        : MerchantProfile.fromJson(json["merchantProfile"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "merchantProfile": merchantProfile?.toJson(),
  };
}

class MerchantProfile {
  int? id;
  String? businessName;
  String? gstinNumber;
  String? businessEmail;
  String? businessContactNumber;
  String? businessWebsite;
  String? website;
  int? yearsInBusiness;
  int? projectsCompleted;
  int? profileCompletionPercentage;
  bool? isProfileComplete;
  bool? identityVerified;
  bool? businessLicense;
  bool? qualityAssurance;
  VerificationStatus? verificationStatus;
  String? trustScore;
  String? marketplaceTier;
  String? memberSince;
  List<BusinessHours>? businessHours;
  List<Documents>? documents;
  String? createdAt;
  String? updatedAt;

  MerchantProfile({
    this.id,
    this.businessName,
    this.gstinNumber,
    this.businessEmail,
    this.businessContactNumber,
    this.businessWebsite,
    this.yearsInBusiness,
    this.projectsCompleted,
    this.profileCompletionPercentage,
    this.isProfileComplete,
    this.website,
    this.identityVerified,
    this.businessLicense,
    this.qualityAssurance,
    this.verificationStatus,
    this.trustScore,
    this.marketplaceTier,
    this.memberSince,
    this.businessHours,
    this.documents,
    this.createdAt,
    this.updatedAt,
  });

  factory MerchantProfile.fromJson(Map<String, dynamic> json) =>
      MerchantProfile(
        id: json["id"],
        businessName: json["businessName"],
        gstinNumber: json["gstinNumber"],
        website: json["website"],
        businessEmail: json["businessEmail"],
        businessContactNumber: json["businessContactNumber"],
        businessWebsite: json["businessWebsite"],
        yearsInBusiness: json["yearsInBusiness"],
        projectsCompleted: json["projectsCompleted"],
        profileCompletionPercentage: json["profileCompletionPercentage"],
        isProfileComplete: json["isProfileComplete"],
        identityVerified: json["identityVerified"],
        businessLicense: json["businessLicense"],
        qualityAssurance: json["qualityAssurance"],
        verificationStatus: json["verificationStatus"] == null
            ? null
            : VerificationStatus.fromJson(json["verificationStatus"]),
        trustScore: json["trustScore"],
        marketplaceTier: json["marketplaceTier"],
        memberSince: json["memberSince"],
        businessHours: json["businessHours"] == null
            ? []
            : List<BusinessHours>.from(
                json["businessHours"]!.map((x) => BusinessHours.fromJson(x)),
              ),
        documents: json["documents"] == null
            ? []
            : List<Documents>.from(
                json["documents"]!.map((x) => Documents.fromJson(x)),
              ),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "businessName": businessName,
    "gstinNumber": gstinNumber,
    "businessEmail": businessEmail,
    "businessContactNumber": businessContactNumber,
    "businessWebsite": businessWebsite,
    "yearsInBusiness": yearsInBusiness,
    "projectsCompleted": projectsCompleted,
    "profileCompletionPercentage": profileCompletionPercentage,
    "isProfileComplete": isProfileComplete,
    "identityVerified": identityVerified,
    "businessLicense": businessLicense,
    "qualityAssurance": qualityAssurance,
    "verificationStatus": verificationStatus?.toJson(),
    "trustScore": trustScore,
    "marketplaceTier": marketplaceTier,
    "memberSince": memberSince,
    "website": website,
    "businessHours": businessHours == null
        ? []
        : List<dynamic>.from(businessHours!.map((x) => x.toJson())),
    "documents": documents == null
        ? []
        : List<dynamic>.from(documents!.map((x) => x.toJson())),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class VerificationStatus {
  bool? identityVerified;
  bool? businessLicense;
  bool? qualityAssurance;

  VerificationStatus({
    this.identityVerified,
    this.businessLicense,
    this.qualityAssurance,
  });

  factory VerificationStatus.fromJson(Map<String, dynamic> json) =>
      VerificationStatus(
        identityVerified: json["identityVerified"],
        businessLicense: json["businessLicense"],
        qualityAssurance: json["qualityAssurance"],
      );

  Map<String, dynamic> toJson() => {
    "identityVerified": identityVerified,
    "businessLicense": businessLicense,
    "qualityAssurance": qualityAssurance,
  };
}

class BusinessHours {
  int? id;
  bool? isOpen;
  String? dayName;
  String? openTime;
  String? closeTime;
  int? dayOfWeek;

  BusinessHours({
    this.id,
    this.isOpen,
    this.dayName,
    this.openTime,
    this.closeTime,
    this.dayOfWeek,
  });

  factory BusinessHours.fromJson(Map<String, dynamic> json) => BusinessHours(
    id: json["id"],
    isOpen: json["is_open"],
    dayName: json["day_name"],
    openTime: json["open_time"],
    closeTime: json["close_time"],
    dayOfWeek: json["day_of_week"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_open": isOpen,
    "day_name": dayName,
    "open_time": openTime,
    "close_time": closeTime,
    "day_of_week": dayOfWeek,
  };
}

class Documents {
  int? id;
  String? filePath;
  int? fileSize;
  String? mimeType;
  bool? isVerified;
  String? documentName;
  String? documentType;

  Documents({
    this.id,
    this.filePath,
    this.fileSize,
    this.mimeType,
    this.isVerified,
    this.documentName,
    this.documentType,
  });

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
    id: json["id"],
    filePath: json["file_path"],
    fileSize: json["file_size"],
    mimeType: json["mime_type"],
    isVerified: json["is_verified"],
    documentName: json["document_name"],
    documentType: json["document_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file_path": filePath,
    "file_size": fileSize,
    "mime_type": mimeType,
    "is_verified": isVerified,
    "document_name": documentName,
    "document_type": documentType,
  };
}

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
