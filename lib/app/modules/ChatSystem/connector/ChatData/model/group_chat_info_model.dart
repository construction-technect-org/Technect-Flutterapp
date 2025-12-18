class GroupChatInfoModel {
  bool? success;
  String? message;
  Data? data;

  GroupChatInfoModel({this.success, this.message, this.data});

  GroupChatInfoModel.fromJson(Map<String, dynamic> json) {
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
  Group? group;
  Lead? lead;
  Merchant? merchant;
  ChatInfo? chatInfo;
  Members? members;

  Data({this.group, this.lead, this.merchant, this.chatInfo, this.members});

  Data.fromJson(Map<String, dynamic> json) {
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
    lead = json['lead'] != null ? Lead.fromJson(json['lead']) : null;
    merchant = json['merchant'] != null
        ? Merchant.fromJson(json['merchant'])
        : null;
    chatInfo = json['chatInfo'] != null
        ? ChatInfo.fromJson(json['chatInfo'])
        : null;
    members =
    json['members'] != null ? Members.fromJson(json['members']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (lead != null) {
      data['lead'] = lead!.toJson();
    }
    if (merchant != null) {
      data['merchant'] = merchant!.toJson();
    }
    if (chatInfo != null) {
      data['chatInfo'] = chatInfo!.toJson();
    }
    if (members != null) {
      data['members'] = members!.toJson();
    }
    return data;
  }
}

class Group {
  int? id;
  int? leadId;
  String? leadIdString;
  String? groupName;
  String? groupDescription;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Group(
      {this.id,
        this.leadId,
        this.leadIdString,
        this.groupName,
        this.groupDescription,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['leadId'];
    leadIdString = json['leadIdString'];
    groupName = json['groupName'];
    groupDescription = json['groupDescription'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leadId'] = leadId;
    data['leadIdString'] = leadIdString;
    data['groupName'] = groupName;
    data['groupDescription'] = groupDescription;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Lead {
  int? id;
  String? leadId;
  String? productName;
  String? serviceName;
  int? connectorId;
  String? connectorName;
  String? connectorProfileImage;

  Lead(
      {this.id,
        this.leadId,
        this.productName,
        this.serviceName,
        this.connectorId,
        this.connectorName,
        this.connectorProfileImage});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['leadId'];
    productName = json['productName'];
    serviceName = json['serviceName'];
    connectorId = json['connectorId'];
    connectorName = json['connectorName'];
    connectorProfileImage = json['connectorProfileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leadId'] = leadId;
    data['productName'] = productName;
    data['serviceName'] = serviceName;
    data['connectorId'] = connectorId;
    data['connectorName'] = connectorName;
    data['connectorProfileImage'] = connectorProfileImage;
    return data;
  }
}

class Merchant {
  int? userId;
  int? profileId;
  String? businessName;
  String? name;
  String? email;
  String? mobileNumber;
  String? countryCode;
  String? logo;

  Merchant(
      {this.userId,
        this.profileId,
        this.businessName,
        this.name,
        this.email,
        this.mobileNumber,
        this.countryCode,
        this.logo});

  Merchant.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    profileId = json['profileId'];
    businessName = json['businessName'];
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    countryCode = json['countryCode'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['profileId'] = profileId;
    data['businessName'] = businessName;
    data['name'] = name;
    data['email'] = email;
    data['mobileNumber'] = mobileNumber;
    data['countryCode'] = countryCode;
    data['logo'] = logo;
    return data;
  }
}

class ChatInfo {
  String? lastMessage;
  String? lastMessageTime;
  String? lastMessageType;
  int? unreadCount;

  ChatInfo(
      {this.lastMessage,
        this.lastMessageTime,
        this.lastMessageType,
        this.unreadCount});

  ChatInfo.fromJson(Map<String, dynamic> json) {
    lastMessage = json['lastMessage'];
    lastMessageTime = json['lastMessageTime'];
    lastMessageType = json['lastMessageType'];
    unreadCount = json['unreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastMessage'] = lastMessage;
    data['lastMessageTime'] = lastMessageTime;
    data['lastMessageType'] = lastMessageType;
    data['unreadCount'] = unreadCount;
    return data;
  }
}

class Members {
  int? total;
  List<MemberList>? list;

  Members({this.total, this.list});

  Members.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = <MemberList>[];
      json['list'].forEach((v) {
        list!.add(MemberList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MemberList {
  int? memberId;
  int? userId;
  String? role;
  String? joinedAt;
  bool? isActive;
  String? userType;
  User? user;
  Connector? connector;

  MemberList(
      {this.memberId,
        this.userId,
        this.role,
        this.joinedAt,
        this.isActive,
        this.userType,
        this.user,
        this.connector});

  MemberList.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    userId = json['userId'];
    role = json['role'];
    joinedAt = json['joinedAt'];
    isActive = json['isActive'];
    userType = json['userType'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    connector = json['connector'] != null
        ? Connector.fromJson(json['connector'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberId'] = memberId;
    data['userId'] = userId;
    data['role'] = role;
    data['joinedAt'] = joinedAt;
    data['isActive'] = isActive;
    data['userType'] = userType;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (connector != null) {
      data['connector'] = connector!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? countryCode;
  String? profileImage;
  String? roleName;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.mobileNumber,
        this.countryCode,
        this.profileImage,
        this.roleName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    countryCode = json['countryCode'];
    profileImage = json['profileImage'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['mobileNumber'] = mobileNumber;
    data['countryCode'] = countryCode;
    data['profileImage'] = profileImage;
    data['roleName'] = roleName;
    return data;
  }
}

class Connector {
  int? id;
  String? aadhaarNumber;
  String? panNumber;

  Connector({this.id, this.aadhaarNumber, this.panNumber});

  Connector.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aadhaarNumber = json['aadhaarNumber'];
    panNumber = json['panNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aadhaarNumber'] = aadhaarNumber;
    data['panNumber'] = panNumber;
    return data;
  }
}
