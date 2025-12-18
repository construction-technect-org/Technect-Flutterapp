
class ChatListModel {
  bool? success;
  List<ChatData>? chatData;

  ChatListModel({this.success, this.chatData,});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      chatData = <ChatData>[];
      json['data'].forEach((v) {
        chatData!.add(ChatData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (chatData != null) {
      data['data'] = chatData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ChatData {
  int? id;
  int? connectionId;
  int? groupId;
  int? senderUserId;
  int? senderTeamMemberId;
  int? receiverUserId;

  String? messageText;
  String? messageType;
  String? messageMediaUrl;

  bool? isRead;
  String? readAt;

  // Event related fields
  String? eventTitle;
  String? eventDescription;
  String? eventDate;
  String? eventTime;
  String? eventStatus;
  int? eventRespondedByUserId;
  String? eventRespondedAt;

  String? createdAt;
  String? updatedAt;

  ChatData({
    this.id,
    this.connectionId,
    this.groupId,
    this.senderUserId,
    this.senderTeamMemberId,
    this.receiverUserId,
    this.messageText,
    this.messageType,
    this.messageMediaUrl,
    this.isRead,
    this.readAt,
    this.eventTitle,
    this.eventDescription,
    this.eventDate,
    this.eventTime,
    this.eventStatus,
    this.eventRespondedByUserId,
    this.eventRespondedAt,
    this.createdAt,
    this.updatedAt,
  });

  ChatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    connectionId = json['connection_id'];
    groupId = json['group_id'];
    senderUserId = json['sender_user_id'];
    senderTeamMemberId = json['sender_team_member_id'];
    receiverUserId = json['receiver_user_id'];

    messageText = json['message_text'];
    messageType = json['message_type'];
    messageMediaUrl = json['message_media_url'];

    isRead = json['is_read'];
    readAt = json['read_at'];

    eventTitle = json['event_title'];
    eventDescription = json['event_description'];
    eventDate = json['event_date'];
    eventTime = json['event_time'];
    eventStatus = json['event_status'];
    eventRespondedByUserId = json['event_responded_by_user_id'];
    eventRespondedAt = json['event_responded_at'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['connection_id'] = connectionId;
    data['group_id'] = groupId;
    data['sender_user_id'] = senderUserId;
    data['sender_team_member_id'] = senderTeamMemberId;
    data['receiver_user_id'] = receiverUserId;

    data['message_text'] = messageText;
    data['message_type'] = messageType;
    data['message_media_url'] = messageMediaUrl;

    data['is_read'] = isRead;
    data['read_at'] = readAt;

    data['event_title'] = eventTitle;
    data['event_description'] = eventDescription;
    data['event_date'] = eventDate;
    data['event_time'] = eventTime;
    data['event_status'] = eventStatus;
    data['event_responded_by_user_id'] = eventRespondedByUserId;
    data['event_responded_at'] = eventRespondedAt;

    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
