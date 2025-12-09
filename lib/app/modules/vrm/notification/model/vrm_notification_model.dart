class VrmNotificationModel {
  bool? success;
  String? message;
  VrmNotificationData? data;

  VrmNotificationModel({this.success, this.message, this.data});

  factory VrmNotificationModel.fromJson(Map<String, dynamic> json) => VrmNotificationModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : VrmNotificationData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "message": message, "data": data?.toJson()};
}

class VrmNotificationData {
  List<VrmNotification>? notifications;
  VrmNotificationPagination? pagination;

  VrmNotificationData({this.notifications, this.pagination});

  factory VrmNotificationData.fromJson(Map<String, dynamic> json) => VrmNotificationData(
    notifications: json["notifications"] == null
        ? []
        : List<VrmNotification>.from(
            json["notifications"]!.map((x) => VrmNotification.fromJson(x)),
          ),
    pagination: json["pagination"] == null
        ? null
        : VrmNotificationPagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications == null
        ? []
        : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class VrmNotification {
  int? id;
  int? connectorUserId;
  String? title;
  String? message;
  String? notificationType;
  String? entityType;
  int? entityId;
  int? merchantUserId;
  String? priority;
  bool? isRead;
  VrmNotificationMetadata? metadata;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic readAt;

  VrmNotification({
    this.id,
    this.connectorUserId,
    this.title,
    this.message,
    this.notificationType,
    this.entityType,
    this.entityId,
    this.merchantUserId,
    this.priority,
    this.isRead,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.readAt,
  });

  factory VrmNotification.fromJson(Map<String, dynamic> json) => VrmNotification(
    id: json["id"],
    connectorUserId: json["connector_user_id"],
    title: json["title"],
    message: json["message"],
    notificationType: json["notification_type"],
    entityType: json["entity_type"],
    entityId: json["entity_id"],
    merchantUserId: json["merchant_user_id"],
    priority: json["priority"],
    isRead: json["is_read"],
    metadata: json["metadata"] == null ? null : VrmNotificationMetadata.fromJson(json["metadata"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    readAt: json["read_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "connector_user_id": connectorUserId,
    "title": title,
    "message": message,
    "notification_type": notificationType,
    "entity_type": entityType,
    "entity_id": entityId,
    "merchant_user_id": merchantUserId,
    "priority": priority,
    "is_read": isRead,
    "metadata": metadata?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "read_at": readAt,
  };
}

class VrmNotificationMetadata {
  int? leadId;
  String? salesId;
  String? currentStage;
  String? merchantName;
  int? salesLeadId;
  String? currentStatus;
  String? leadIdString;
  String? accountId;
  int? accountLeadId;

  VrmNotificationMetadata({
    this.leadId,
    this.salesId,
    this.currentStage,
    this.merchantName,
    this.salesLeadId,
    this.currentStatus,
    this.leadIdString,
    this.accountId,
    this.accountLeadId,
  });

  factory VrmNotificationMetadata.fromJson(Map<String, dynamic> json) => VrmNotificationMetadata(
    leadId: json["lead_id"],
    salesId: json["sales_id"],
    currentStage: json["current_stage"],
    merchantName: json["merchant_name"],
    salesLeadId: json["sales_lead_id"],
    currentStatus: json["current_status"],
    leadIdString: json["lead_id_string"],
    accountId: json["account_id"],
    accountLeadId: json["account_lead_id"],
  );

  Map<String, dynamic> toJson() => {
    "lead_id": leadId,
    "sales_id": salesId,
    "current_stage": currentStage,
    "merchant_name": merchantName,
    "sales_lead_id": salesLeadId,
    "current_status": currentStatus,
    "lead_id_string": leadIdString,
    "account_id": accountId,
    "account_lead_id": accountLeadId,
  };
}

class VrmNotificationPagination {
  int? total;
  int? limit;
  int? offset;
  bool? hasMore;

  VrmNotificationPagination({this.total, this.limit, this.offset, this.hasMore});

  factory VrmNotificationPagination.fromJson(Map<String, dynamic> json) =>
      VrmNotificationPagination(
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
