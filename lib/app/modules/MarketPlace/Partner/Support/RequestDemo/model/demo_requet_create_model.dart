class DemoRequestCreateModel {
  bool? success;
  Data? data;
  String? message;

  DemoRequestCreateModel({this.success, this.data, this.message});

  factory DemoRequestCreateModel.fromJson(Map<String, dynamic> json) =>
      DemoRequestCreateModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  int? id;
  int? userId;
  String? demoFor;
  String? phoneNumber;
  String? email;
  String? status;
  dynamic adminNotes;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? connectorProfileId;

  Data({
    this.id,
    this.userId,
    this.demoFor,
    this.phoneNumber,
    this.email,
    this.status,
    this.adminNotes,
    this.createdAt,
    this.updatedAt,
    this.connectorProfileId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    demoFor: json["demo_for"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    status: json["status"],
    adminNotes: json["admin_notes"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    connectorProfileId: json["connector_profile_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "demo_for": demoFor,
    "phone_number": phoneNumber,
    "email": email,
    "status": status,
    "admin_notes": adminNotes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "connector_profile_id": connectorProfileId,
  };
}
