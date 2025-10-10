class SiteAddressModel {
  bool? success;
  String? message;
  List<Datum>? data;

  SiteAddressModel({this.success, this.message, this.data});

  factory SiteAddressModel.fromJson(Map<String, dynamic> json) => SiteAddressModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null
        ? []
        : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int? userId;
  String? siteName;
  String? fullAddress;
  String? landmark;
  String? latitude;
  String? longitude;
  bool? isDefault;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.siteName,
    this.fullAddress,
    this.landmark,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    siteName: json["site_name"],
    fullAddress: json["full_address"],
    landmark: json["landmark"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isDefault: json["is_default"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "site_name": siteName,
    "full_address": fullAddress,
    "landmark": landmark,
    "latitude": latitude,
    "longitude": longitude,
    "is_default": isDefault,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
