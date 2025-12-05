class CrmInboxModel {
  bool? success;
  String? message;
  Data? data;

  CrmInboxModel({this.success, this.message, this.data});

  factory CrmInboxModel.fromJson(Map<String, dynamic> json) => CrmInboxModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "message": message, "data": data?.toJson()};
}

class Data {
  List<CrmInbox>? notifications;
  Pagination? pagination;

  Data({this.notifications, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: json["notifications"] == null
        ? []
        : List<CrmInbox>.from(json["notifications"]!.map((x) => CrmInbox.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications == null
        ? []
        : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class CrmInbox {
  int? id;
  int? merchantUserId;
  String? title;
  String? message;
  String? notificationType;
  String? entityType;
  int? entityId;
  String? priority;
  bool? isRead;
  Metadata? metadata;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic readAt;

  CrmInbox({
    this.id,
    this.merchantUserId,
    this.title,
    this.message,
    this.notificationType,
    this.entityType,
    this.entityId,
    this.priority,
    this.isRead,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.readAt,
  });

  factory CrmInbox.fromJson(Map<String, dynamic> json) => CrmInbox(
    id: json["id"],
    merchantUserId: json["merchant_user_id"],
    title: json["title"],
    message: json["message"],
    notificationType: json["notification_type"],
    entityType: json["entity_type"],
    entityId: json["entity_id"],
    priority: json["priority"],
    isRead: json["is_read"],
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    readAt: json["read_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_user_id": merchantUserId,
    "title": title,
    "message": message,
    "notification_type": notificationType,
    "entity_type": entityType,
    "entity_id": entityId,
    "priority": priority,
    "is_read": isRead,
    "metadata": metadata?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "read_at": readAt,
  };
}

class Metadata {
  int? leadId;
  String? accountId;
  String? leadIdString;
  int? accountLeadId;
  int? salesLeadId;

  Metadata({this.leadId, this.accountId, this.leadIdString, this.accountLeadId, this.salesLeadId});

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    leadId: json["lead_id"],
    accountId: json["account_id"],
    leadIdString: json["lead_id_string"],
    accountLeadId: json["account_lead_id"],
    salesLeadId: json["sales_lead_id"],
  );

  Map<String, dynamic> toJson() => {
    "lead_id": leadId,
    "account_id": accountId,
    "lead_id_string": leadIdString,
    "account_lead_id": accountLeadId,
    "sales_lead_id": salesLeadId,
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
