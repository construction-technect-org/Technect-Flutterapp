class ApprovalInboxService {
  bool? success;
  Data? data;

  ApprovalInboxService({this.success, this.data});

  ApprovalInboxService.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Notifications>? notifications;
  Pagination? pagination;

  Data({this.notifications, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] =
          notifications!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Notifications {
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
  String? createdAt;
  String? updatedAt;
  Null? readAt;

  Notifications(
      {this.id,
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
        this.readAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    merchantProfileId = json['merchant_profile_id'];
    title = json['title'];
    message = json['message'];
    notificationType = json['notification_type'];
    entityType = json['entity_type'];
    entityId = json['entity_id'];
    status = json['status'];
    isRead = json['is_read'];
    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    readAt = json['read_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['merchant_profile_id'] = merchantProfileId;
    data['title'] = title;
    data['message'] = message;
    data['notification_type'] = notificationType;
    data['entity_type'] = entityType;
    data['entity_id'] = entityId;
    data['status'] = status;
    data['is_read'] = isRead;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['read_at'] = readAt;
    return data;
  }
}

class Metadata {
  String? action;
  String? productName;

  Metadata({this.action, this.productName});

  Metadata.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action'] = action;
    data['product_name'] = productName;
    return data;
  }
}

class Pagination {
  int? total;
  int? limit;
  int? offset;
  bool? hasMore;

  Pagination({this.total, this.limit, this.offset, this.hasMore});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    offset = json['offset'];
    hasMore = json['has_more'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['limit'] = limit;
    data['offset'] = offset;
    data['has_more'] = hasMore;
    return data;
  }
}
