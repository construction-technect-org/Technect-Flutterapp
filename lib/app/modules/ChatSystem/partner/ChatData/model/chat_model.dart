class ChatListModel {
  bool? success;
  List<ChatData>? chatData;
  Pagination? pagination;

  ChatListModel({this.success, this.chatData, this.pagination});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      chatData = <ChatData>[];
      json['data'].forEach((v) {
        chatData!.add(ChatData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (chatData != null) {
      data['data'] = chatData!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class ChatData {
  int? id;
  int? connectionId;
  int? senderUserId;
  int? receiverUserId;
  String? messageText;
  String? messageType;
  String? messageMediaUrl;
  bool? isRead;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  ChatData({
    this.id,
    this.connectionId,
    this.senderUserId,
    this.receiverUserId,
    this.messageText,
    this.messageType,
    this.messageMediaUrl,
    this.isRead,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  ChatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    connectionId = json['connection_id'];
    senderUserId = json['sender_user_id'];
    receiverUserId = json['receiver_user_id'];
    messageText = json['message_text'];
    messageType = json['message_type'];
    messageMediaUrl = json['message_media_url'];
    isRead = json['is_read'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['connection_id'] = connectionId;
    data['sender_user_id'] = senderUserId;
    data['receiver_user_id'] = receiverUserId;
    data['message_text'] = messageText;
    data['message_type'] = messageType;
    data['message_media_url'] = messageMediaUrl;
    data['is_read'] = isRead;
    data['read_at'] = readAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? total;
  int? totalPages;

  Pagination({this.page, this.limit, this.total, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['totalPages'] = totalPages;
    return data;
  }
}
