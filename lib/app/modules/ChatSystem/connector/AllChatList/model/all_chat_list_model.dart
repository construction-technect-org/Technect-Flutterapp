import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class AllChatListModel {
  bool? success;
  Chats? chats;
  String? message;

  AllChatListModel({this.success, this.chats, this.message});

  AllChatListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    chats = json['data'] != null ? Chats.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (chats != null) {
      data['data'] = chats!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Chats {
  List<Conversations>? conversations;
  int? totalConversations;
  int? enabledChats;

  Chats({this.conversations, this.totalConversations, this.enabledChats});

  Chats.fromJson(Map<String, dynamic> json) {
    if (json['conversations'] != null) {
      conversations = <Conversations>[];
      json['conversations'].forEach((v) {
        conversations!.add(Conversations.fromJson(v));
      });
    }
    totalConversations = json['total_conversations'];
    enabledChats = json['enabled_chats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (conversations != null) {
      data['conversations'] =
          conversations!.map((v) => v.toJson()).toList();
    }
    data['total_conversations'] = totalConversations;
    data['enabled_chats'] = enabledChats;
    return data;
  }
}

class Conversations {
  int? connectionId;
  Connector? connector;
  Product? product;
  ConnectionInfo? connectionInfo;
  ChatInfo? chatInfo;

  Conversations(
      {this.connectionId,
        this.connector,
        this.product,
        this.connectionInfo,
        this.chatInfo});

  Conversations.fromJson(Map<String, dynamic> json) {
    connectionId = json['connection_id'];
    connector = json['connector'] != null
        ? Connector.fromJson(json['connector'])
        : null;
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    connectionInfo = json['connection_info'] != null
        ? ConnectionInfo.fromJson(json['connection_info'])
        : null;
    chatInfo = json['chat_info'] != null
        ? ChatInfo.fromJson(json['chat_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['connection_id'] = connectionId;
    if (connector != null) {
      data['connector'] = connector!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (connectionInfo != null) {
      data['connection_info'] = connectionInfo!.toJson();
    }
    if (chatInfo != null) {
      data['chat_info'] = chatInfo!.toJson();
    }
    return data;
  }
}

class Connector {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? mobileNumber;
  String? countryCode;
  String? email;

  Connector(
      {this.id,
        this.userId,
        this.firstName,
        this.lastName,
        this.profileImage,
        this.mobileNumber,
        this.countryCode,
        this.email});

  Connector.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'];
    mobileNumber = json['mobile_number'];
    countryCode = json['country_code'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_image'] = profileImage;
    data['mobile_number'] = mobileNumber;
    data['country_code'] = countryCode;
    data['email'] = email;
    return data;
  }
}


class FilterValues {
  Uom? uom;
  Uoc? uoc;
  PackageType? packageType;
  Uom? packageSize;
  PackageType? shape;
  PackageType? texture;
  PackageType? colour;
  Uom? size;
  PackageType? finenessModulus;
  PackageType? specificGravity;
  Uom? bulkDensity;
  Uom? waterAbsorption;
  Uom? moistureContent;
  Uom? clayDustContent;
  Uom? siltContent;
  PackageType? machineType;

  FilterValues(
      {this.uom,
        this.uoc,
        this.packageType,
        this.packageSize,
        this.shape,
        this.texture,
        this.colour,
        this.size,
        this.finenessModulus,
        this.specificGravity,
        this.bulkDensity,
        this.waterAbsorption,
        this.moistureContent,
        this.clayDustContent,
        this.siltContent,
        this.machineType});

  FilterValues.fromJson(Map<String, dynamic> json) {
    uom = json['uom'] != null ? Uom.fromJson(json['uom']) : null;
    uoc = json['uoc'] != null ? Uoc.fromJson(json['uoc']) : null;
    packageType = json['package_type'] != null
        ? PackageType.fromJson(json['package_type'])
        : null;
    packageSize = json['package_size'] != null
        ? Uom.fromJson(json['package_size'])
        : null;
    shape =
    json['shape'] != null ? PackageType.fromJson(json['shape']) : null;
    texture = json['texture'] != null
        ? PackageType.fromJson(json['texture'])
        : null;
    colour = json['colour'] != null
        ? PackageType.fromJson(json['colour'])
        : null;
    size = json['size'] != null ? Uom.fromJson(json['size']) : null;
    finenessModulus = json['fineness_modulus'] != null
        ? PackageType.fromJson(json['fineness_modulus'])
        : null;
    specificGravity = json['specific_gravity'] != null
        ? PackageType.fromJson(json['specific_gravity'])
        : null;
    bulkDensity = json['bulk_density'] != null
        ? Uom.fromJson(json['bulk_density'])
        : null;
    waterAbsorption = json['water_absorption'] != null
        ? Uom.fromJson(json['water_absorption'])
        : null;
    moistureContent = json['moisture_content'] != null
        ? Uom.fromJson(json['moisture_content'])
        : null;
    clayDustContent = json['clay_dust_content'] != null
        ? Uom.fromJson(json['clay_dust_content'])
        : null;
    siltContent = json['silt_content'] != null
        ? Uom.fromJson(json['silt_content'])
        : null;
    machineType = json['machine_type'] != null
        ? PackageType.fromJson(json['machine_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uom != null) {
      data['uom'] = uom!.toJson();
    }
    if (uoc != null) {
      data['uoc'] = uoc!.toJson();
    }
    if (packageType != null) {
      data['package_type'] = packageType!.toJson();
    }
    if (packageSize != null) {
      data['package_size'] = packageSize!.toJson();
    }
    if (shape != null) {
      data['shape'] = shape!.toJson();
    }
    if (texture != null) {
      data['texture'] = texture!.toJson();
    }
    if (colour != null) {
      data['colour'] = colour!.toJson();
    }
    if (size != null) {
      data['size'] = size!.toJson();
    }
    if (finenessModulus != null) {
      data['fineness_modulus'] = finenessModulus!.toJson();
    }
    if (specificGravity != null) {
      data['specific_gravity'] = specificGravity!.toJson();
    }
    if (bulkDensity != null) {
      data['bulk_density'] = bulkDensity!.toJson();
    }
    if (waterAbsorption != null) {
      data['water_absorption'] = waterAbsorption!.toJson();
    }
    if (moistureContent != null) {
      data['moisture_content'] = moistureContent!.toJson();
    }
    if (clayDustContent != null) {
      data['clay_dust_content'] = clayDustContent!.toJson();
    }
    if (siltContent != null) {
      data['silt_content'] = siltContent!.toJson();
    }
    if (machineType != null) {
      data['machine_type'] = machineType!.toJson();
    }
    return data;
  }
}

class Uom {
  String? value;
  String? displayValue;
  String? unit;
  String? label;
  String? type;

  Uom({this.value, this.displayValue, this.unit, this.label, this.type});

  Uom.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    displayValue = json['display_value'];
    unit = json['unit'];
    label = json['label'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['display_value'] = displayValue;
    data['unit'] = unit;
    data['label'] = label;
    data['type'] = type;
    return data;
  }
}

class Uoc {
  List<String>? value;
  String? displayValue;
  String? unit;
  String? label;
  String? type;

  Uoc({this.value, this.displayValue, this.unit, this.label, this.type});

  Uoc.fromJson(Map<String, dynamic> json) {
    value = json['value'].cast<String>();
    displayValue = json['display_value'];
    unit = json['unit'];
    label = json['label'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['display_value'] = displayValue;
    data['unit'] = unit;
    data['label'] = label;
    data['type'] = type;
    return data;
  }
}

class PackageType {
  String? value;
  String? displayValue;
  String? unit;
  String? label;
  String? type;

  PackageType(
      {this.value, this.displayValue, this.unit, this.label, this.type});

  PackageType.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    displayValue = json['display_value'];
    unit = json['unit'];
    label = json['label'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['display_value'] = displayValue;
    data['unit'] = unit;
    data['label'] = label;
    data['type'] = type;
    return data;
  }
}

class Images {
  String? s3Key;
  String? s3Url;
  int? sortOrder;
  String? mediaType;

  Images({this.s3Key, this.s3Url, this.sortOrder, this.mediaType});

  Images.fromJson(Map<String, dynamic> json) {
    s3Key = json['s3_key'];
    s3Url = json['s3_url'];
    sortOrder = json['sort_order'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s3_key'] = s3Key;
    data['s3_url'] = s3Url;
    data['sort_order'] = sortOrder;
    data['media_type'] = mediaType;
    return data;
  }
}

class ConnectionInfo {
  String? connectedAt;
  String? requestMessage;
  String? responseMessage;

  ConnectionInfo({this.connectedAt, this.requestMessage, this.responseMessage});

  ConnectionInfo.fromJson(Map<String, dynamic> json) {
    connectedAt = json['connected_at'];
    requestMessage = json['request_message'];
    responseMessage = json['response_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['connected_at'] = connectedAt;
    data['request_message'] = requestMessage;
    data['response_message'] = responseMessage;
    return data;
  }
}

class ChatInfo {
  String? lastMessage;
  String? lastMessageTime;
  int? unreadCount;

  ChatInfo({this.lastMessage, this.lastMessageTime, this.unreadCount});

  ChatInfo.fromJson(Map<String, dynamic> json) {
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
    unreadCount = json['unread_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_message'] = lastMessage;
    data['last_message_time'] = lastMessageTime;
    data['unread_count'] = unreadCount;
    return data;
  }
}
