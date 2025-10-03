class ConnectionModel {
  bool? success;
  String? message;
  List<Connection>? data;
  Statistics? statistics;

  ConnectionModel({this.success, this.message, this.data, this.statistics});

  factory ConnectionModel.fromJson(Map<String, dynamic> json) => ConnectionModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null
        ? []
        : List<Connection>.from(json["data"]!.map((x) => Connection.fromJson(x))),
    statistics: json["statistics"] == null
        ? null
        : Statistics.fromJson(json["statistics"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
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
  dynamic connectedAt;
  String? connectorName;
  String? connectorProfileImageUrl;
  String? merchantName;
  String? merchantProfileImageUrl;
  String? productName;
  DateTime? createdAt;
  DateTime? updatedAt;

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
    this.createdAt,
    this.updatedAt,
  });

  factory Connection.fromJson(Map<String, dynamic> json) => Connection(
    id: json["id"],
    connectorUserId: json["connector_user_id"],
    merchantProfileId: json["merchant_profile_id"],
    productId: json["product_id"],
    status: json["status"],
    requestMessage: json["request_message"],
    responseMessage: json["response_message"],
    connectedAt: json["connected_at"],
    connectorName: json["connector_name"],
    connectorProfileImageUrl: json["connector_profile_image_url"],
    merchantName: json["merchant_name"],
    merchantProfileImageUrl: json["merchant_profile_image_url"],
    productName: json["product_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "connector_user_id": connectorUserId,
    "merchant_profile_id": merchantProfileId,
    "product_id": productId,
    "status": status,
    "request_message": requestMessage,
    "response_message": responseMessage,
    "connected_at": connectedAt,
    "connector_name": connectorName,
    "connector_profile_image_url": connectorProfileImageUrl,
    "merchant_name": merchantName,
    "merchant_profile_image_url": merchantProfileImageUrl,
    "product_name": productName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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
