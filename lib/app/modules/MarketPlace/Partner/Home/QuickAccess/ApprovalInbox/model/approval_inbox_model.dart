class ApprovalInboxModel {
  bool? success;
  Data? data;

  ApprovalInboxModel({this.success, this.data});

  factory ApprovalInboxModel.fromJson(Map<String, dynamic> json) => ApprovalInboxModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class Data {
  List<ApprovalInbox>? approvalInbox;
  Pagination? pagination;
  ProductStatistics? productStatistics;

  Data({this.approvalInbox, this.pagination, this.productStatistics});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    approvalInbox: json["notifications"] == null
        ? []
        : List<ApprovalInbox>.from(
            json["notifications"]!.map((x) => ApprovalInbox.fromJson(x)),
          ),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
    productStatistics: json["product_statistics"] == null
        ? null
        : ProductStatistics.fromJson(json["product_statistics"]),
  );

  Map<String, dynamic> toJson() => {
    "notifications": approvalInbox == null
        ? []
        : List<dynamic>.from(approvalInbox!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
    "product_statistics": productStatistics?.toJson(),
  };
}

class ApprovalInbox {
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
  dynamic readAt;

  ApprovalInbox({
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

  factory ApprovalInbox.fromJson(Map<String, dynamic> json) => ApprovalInbox(
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
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    readAt: json["read_at"],
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
    "read_at": readAt,
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

class ProductStatistics {
  int? totalProducts;
  int? approvedProducts;
  int? rejectedProducts;
  int? pendingProducts;
  int? holdProducts;
  int? activeProducts;
  int? inactiveProducts;

  ProductStatistics({
    this.totalProducts,
    this.approvedProducts,
    this.rejectedProducts,
    this.pendingProducts,
    this.holdProducts,
    this.activeProducts,
    this.inactiveProducts,
  });

  factory ProductStatistics.fromJson(Map<String, dynamic> json) => ProductStatistics(
    totalProducts: json["total_products"],
    approvedProducts: json["approved_products"],
    rejectedProducts: json["rejected_products"],
    pendingProducts: json["pending_products"],
    holdProducts: json["hold_products"],
    activeProducts: json["active_products"],
    inactiveProducts: json["inactive_products"],
  );

  Map<String, dynamic> toJson() => {
    "total_products": totalProducts,
    "approved_products": approvedProducts,
    "rejected_products": rejectedProducts,
    "pending_products": pendingProducts,
    "hold_products": holdProducts,
    "active_products": activeProducts,
    "inactive_products": inactiveProducts,
  };
}
