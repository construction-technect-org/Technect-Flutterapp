class ConnectionModel {
  bool? success;
  String? message;
  List<Connection>? data;
  Statistics? statistics;

  ConnectionModel({this.success, this.message, this.data, this.statistics});

  factory ConnectionModel.fromJson(Map<String, dynamic> json) =>
      ConnectionModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Connection>.from(
                json["data"]!.map((x) => Connection.fromJson(x)),
              ),
        statistics: json["statistics"] == null
            ? null
            : Statistics.fromJson(json["statistics"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "statistics": statistics?.toJson(),
  };
}

class Connection {
  int? id;
  int? connectorUserId;
  int? merchantProfileId;
  int? productId;
  String? status;
  String? requestMessage;
  dynamic responseMessage;
  DateTime? connectedAt;
  String? connectorName;
  String? connectorProfileImageUrl;
  String? merchantName;
  String? merchantProfileImageUrl;
  String? productName;
  int? serviceId;
  String? serviceName;
  String? itemType;
  DateTime? createdAt;
  DateTime? updatedAt;
  ConnectionStatistics? statistics;

  Connection({
    this.id,
    this.connectorUserId,
    this.merchantProfileId,
    this.productId,
    this.status,
    this.requestMessage,
    this.responseMessage,
    this.connectedAt,
    this.connectorName,
    this.connectorProfileImageUrl,
    this.merchantName,
    this.merchantProfileImageUrl,
    this.productName,
    this.serviceId,
    this.serviceName,
    this.itemType,
    this.createdAt,
    this.updatedAt,
    this.statistics,
  });

  factory Connection.fromJson(Map<String, dynamic> json) => Connection(
    id: json["id"],
    connectorUserId: json["connector_user_id"],
    merchantProfileId: json["merchant_profile_id"],
    productId: json["product_id"],
    status: json["status"],
    requestMessage: json["request_message"],
    responseMessage: json["response_message"],
    connectedAt: json["connected_at"] == null
        ? null
        : DateTime.tryParse(json["connected_at"]), // ✅ safer parsing
    connectorName: json["connector_name"],
    connectorProfileImageUrl: json["connector_profile_image_url"],
    merchantName: json["merchant_name"],
    merchantProfileImageUrl: json["merchant_profile_image_url"],
    productName: json["product_name"],
    serviceId: json["service_id"],
    serviceName: json["service_name"],
    itemType: json["item_type"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"]),
    statistics: json["statistics"] == null
        ? null
        : ConnectionStatistics.fromJson(json["statistics"]), // ✅ optional
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "connector_user_id": connectorUserId,
    "merchant_profile_id": merchantProfileId,
    "product_id": productId,
    "status": status,
    "request_message": requestMessage,
    "response_message": responseMessage,
    "connected_at": connectedAt?.toIso8601String(),
    "connector_name": connectorName,
    "connector_profile_image_url": connectorProfileImageUrl,
    "merchant_name": merchantName,
    "merchant_profile_image_url": merchantProfileImageUrl,
    "product_name": productName,
    "service_id": serviceId,
    "service_name": serviceName,
    "item_type": itemType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    if (statistics != null) "statistics": statistics!.toJson(),
  };
}

class ConnectionStatistics {
  int? totalRequests;
  int? pendingRequests;
  int? acceptedRequests;
  int? rejectedRequests;
  int? cancelledRequests;

  ConnectionStatistics({
    this.totalRequests,
    this.pendingRequests,
    this.acceptedRequests,
    this.rejectedRequests,
    this.cancelledRequests,
  });

  factory ConnectionStatistics.fromJson(Map<String, dynamic> json) =>
      ConnectionStatistics(
        totalRequests: json["total_requests"],
        pendingRequests: json["pending_requests"],
        acceptedRequests: json["accepted_requests"],
        rejectedRequests: json["rejected_requests"],
        cancelledRequests: json["cancelled_requests"],
      );

  Map<String, dynamic> toJson() => {
    "total_requests": totalRequests,
    "pending_requests": pendingRequests,
    "accepted_requests": acceptedRequests,
    "rejected_requests": rejectedRequests,
    "cancelled_requests": cancelledRequests,
  };
}

class Statistics {
  String? totalRequests;
  String? pending;
  String? accepted;
  String? rejected;
  String? cancelled;

  Statistics({
    this.totalRequests,
    this.pending,
    this.accepted,
    this.rejected,
    this.cancelled,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    totalRequests: json["total_requests"],
    pending: json["pending"],
    accepted: json["accepted"],
    rejected: json["rejected"],
    cancelled: json["cancelled"],
  );

  Map<String, dynamic> toJson() => {
    "total_requests": totalRequests,
    "pending": pending,
    "accepted": accepted,
    "rejected": rejected,
    "cancelled": cancelled,
  };
}
