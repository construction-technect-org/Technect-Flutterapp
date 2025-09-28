import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  bool? success;
  Data? data;

  NotificationModel({this.success, this.data});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class Data {
  List<Notification>? notifications;
  Pagination? pagination;

  Data({this.notifications, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: json["notifications"] == null
        ? []
        : List<Notification>.from(
            json["notifications"]!.map((x) => Notification.fromJson(x)),
          ),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications == null
        ? []
        : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Notification {
  int? id;
  int? userId;
  int? merchantProfileId;
  String? title;
  String? message;
  String? notificationType;
  String? entityType;
  int? entityId;
  String? status;
  bool? isRead;
  Metadata? metadata;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? readAt;

  Notification({
    this.id,
    this.userId,
    this.merchantProfileId,
    this.title,
    this.message,
    this.notificationType,
    this.entityType,
    this.entityId,
    this.status,
    this.isRead,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.readAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    userId: json["user_id"],
    merchantProfileId: json["merchant_profile_id"],
    title: json["title"],
    message: json["message"],
    notificationType: json["notification_type"],
    entityType: json["entity_type"],
    entityId: json["entity_id"],
    status: json["status"],
    isRead: json["is_read"],
    metadata: json["metadata"] == null
        ? null
        : Metadata.fromJson(json["metadata"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    readAt: json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "merchant_profile_id": merchantProfileId,
    "title": title,
    "message": message,
    "notification_type": notificationType,
    "entity_type": entityType,
    "entity_id": entityId,
    "status": status,
    "is_read": isRead,
    "metadata": metadata?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "read_at": readAt?.toIso8601String(),
  };
}

class Metadata {
  String? action;
  String? productName;
  String? adminComment;

  Metadata({this.action, this.productName, this.adminComment});

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    action: json["action"],
    productName: json["product_name"],
    adminComment: json["admin_comment"],
  );

  Map<String, dynamic> toJson() => {
    "action": action,
    "product_name": productName,
    "admin_comment": adminComment,
  };
}

class Pagination {
  int? total;
  int? limit;
  int? offset;
  bool? hasMore;

  Pagination({this.total, this.limit, this.offset, this.hasMore});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    limit: json["limit"],
    offset: json["offset"],
    hasMore: json["has_more"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "limit": limit,
    "offset": offset,
    "has_more": hasMore,
  };
}
