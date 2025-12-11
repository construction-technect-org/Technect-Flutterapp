class AllCRMGroupChatListModel {
  bool? success;
  String? message;
  Data? data;

  AllCRMGroupChatListModel({this.success, this.message, this.data});

  AllCRMGroupChatListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Groups>? groups;
  int? totalGroups;

  Data({this.groups, this.totalGroups});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['groups'] != null) {
      groups = <Groups>[];
      json['groups'].forEach((v) {
        groups!.add(Groups.fromJson(v));
      });
    }
    totalGroups = json['total_groups'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (groups != null) {
      data['groups'] = groups!.map((v) => v.toJson()).toList();
    }
    data['total_groups'] = totalGroups;
    return data;
  }
}

class Groups {
  int? groupId;
  int? leadId;
  String? leadIdString;
  String? groupName;
  String? productName;
  String? serviceName;
  String? connectorId;
  String? connectorName;
  String? connectorProfileImage;
  int? merchantUserId;
  int? merchantProfileId;
  String? merchantName;
  String? merchantLogo;
  String? lastMessage;
  String? lastMessageTime;
  String? lastMessageType;
  int? unreadCount;
  String? createdAt;

  Groups(
      {this.groupId,
        this.leadId,
        this.leadIdString,
        this.groupName,
        this.productName,
        this.serviceName,
        this.connectorId,
        this.connectorName,
        this.connectorProfileImage,
        this.merchantUserId,
        this.merchantProfileId,
        this.merchantName,
        this.merchantLogo,
        this.lastMessage,
        this.lastMessageTime,
        this.lastMessageType,
        this.unreadCount,
        this.createdAt});

  Groups.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    leadId = json['lead_id'];
    leadIdString = json['lead_id_string'];
    groupName = json['group_name'];
    productName = json['product_name'];
    serviceName = json['service_name'];
    connectorId = json['connector_id'];
    connectorName = json['connector_name'];
    connectorProfileImage = json['connector_profile_image'];
    merchantUserId = json['merchant_user_id'];
    merchantProfileId = json['merchant_profile_id'];
    merchantName = json['merchant_name'];
    merchantLogo = json['merchant_logo'];
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
    lastMessageType = json['last_message_type'];
    unreadCount = json['unread_count'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = groupId;
    data['lead_id'] = leadId;
    data['lead_id_string'] = leadIdString;
    data['group_name'] = groupName;
    data['product_name'] = productName;
    data['service_name'] = serviceName;
    data['connector_id'] = connectorId;
    data['connector_name'] = connectorName;
    data['connector_profile_image'] = connectorProfileImage;
    data['merchant_user_id'] = merchantUserId;
    data['merchant_profile_id'] = merchantProfileId;
    data['merchant_name'] = merchantName;
    data['merchant_logo'] = merchantLogo;
    data['last_message'] = lastMessage;
    data['last_message_time'] = lastMessageTime;
    data['last_message_type'] = lastMessageType;
    data['unread_count'] = unreadCount;
    data['created_at'] = createdAt;
    return data;
  }
}
