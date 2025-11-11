class ConnectorAllChatListModel {
  bool? success;
  Chats? chats;
  String? message;

  ConnectorAllChatListModel({this.success, this.chats, this.message});

  ConnectorAllChatListModel.fromJson(Map<String, dynamic> json) {
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
  Merchant? merchant;
  Product? product;
  ConnectionInfo? connectionInfo;
  ChatInfo? chatInfo;

  Conversations(
      {this.connectionId,
        this.merchant,
        this.product,
        this.connectionInfo,
        this.chatInfo});

  Conversations.fromJson(Map<String, dynamic> json) {
    connectionId = json['connection_id'];
    merchant = json['merchant'] != null
        ? Merchant.fromJson(json['merchant'])
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
    if (merchant != null) {
      data['merchant'] = merchant!.toJson();
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

class Merchant {
  int? id;
  int? userId;
  String? businessName;
  String? businessEmail;
  String? businessContactNumber;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? mobileNumber;
  String? countryCode;
  String? email;

  Merchant(
      {this.id,
        this.userId,
        this.businessName,
        this.businessEmail,
        this.businessContactNumber,
        this.firstName,
        this.lastName,
        this.profileImage,
        this.mobileNumber,
        this.countryCode,
        this.email});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    businessName = json['business_name'];
    businessEmail = json['business_email'];
    businessContactNumber = json['business_contact_number'];
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
    data['business_name'] = businessName;
    data['business_email'] = businessEmail;
    data['business_contact_number'] = businessContactNumber;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_image'] = profileImage;
    data['mobile_number'] = mobileNumber;
    data['country_code'] = countryCode;
    data['email'] = email;
    return data;
  }
}

class Product {
  int? id;
  int? merchantProfileId;
  int? mainCategoryId;
  int? subCategoryId;
  int? categoryProductId;
  String? brand;
  String? price;
  String? gstPercentage;
  String? gstAmount;
  String? termsAndConditions;
  String? createdAt;
  String? updatedAt;
  String? averageRating;
  int? totalRatings;
  int? ratingCount;
  String? productCode;
  String? totalAmount;
  String? productNote;
  bool? outofstock;
  String? approvalStatus;
  int? approvedBy;
  String? approvedAt;
  String? rejectionReason;
  String? approvalNotes;
  int? stockQty;
  String? address;
  String? latitude;
  String? longitude;
  int? productSubCategoryId;
  String? warehouseType;
  String? stockYardAddress;
  String? mainCategoryName;
  String? subCategoryName;
  String? categoryProductName;

  Product(
      {this.id,
        this.merchantProfileId,
        this.mainCategoryId,
        this.subCategoryId,
        this.categoryProductId,
        this.brand,
        this.price,
        this.gstPercentage,
        this.gstAmount,
        this.termsAndConditions,
        this.createdAt,
        this.updatedAt,
        this.averageRating,
        this.totalRatings,
        this.ratingCount,
        this.productCode,
        this.totalAmount,
        this.productNote,
        this.outofstock,
        this.approvalStatus,
        this.approvedBy,
        this.approvedAt,
        this.rejectionReason,
        this.approvalNotes,
        this.stockQty,
        this.address,
        this.latitude,
        this.longitude,
        this.productSubCategoryId,
        this.warehouseType,
        this.stockYardAddress,
        this.mainCategoryName,
        this.subCategoryName,
        this.categoryProductName});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantProfileId = json['merchant_profile_id'];
    mainCategoryId = json['main_category_id'];
    subCategoryId = json['sub_category_id'];
    categoryProductId = json['category_product_id'];
    brand = json['brand'];
    price = json['price'];
    gstPercentage = json['gst_percentage'];
    gstAmount = json['gst_amount'];
    termsAndConditions = json['terms_and_conditions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    averageRating = json['average_rating'];
    totalRatings = json['total_ratings'];
    ratingCount = json['rating_count'];
    productCode = json['product_code'];
    totalAmount = json['total_amount'];
    productNote = json['product_note'];
    outofstock = json['outofstock'];
    approvalStatus = json['approval_status'];
    approvedBy = json['approved_by'];
    approvedAt = json['approved_at'];
    rejectionReason = json['rejection_reason'];
    approvalNotes = json['approval_notes'];
    stockQty = json['stock_qty'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    productSubCategoryId = json['product_sub_category_id'];
    warehouseType = json['warehouse_type'];
    stockYardAddress = json['stock_yard_address'];
    mainCategoryName = json['main_category_name'];
    subCategoryName = json['sub_category_name'];
    categoryProductName = json['category_product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_profile_id'] = merchantProfileId;
    data['main_category_id'] = mainCategoryId;
    data['sub_category_id'] = subCategoryId;
    data['category_product_id'] = categoryProductId;
    data['brand'] = brand;
    data['price'] = price;
    data['gst_percentage'] = gstPercentage;
    data['gst_amount'] = gstAmount;
    data['terms_and_conditions'] = termsAndConditions;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['average_rating'] = averageRating;
    data['total_ratings'] = totalRatings;
    data['rating_count'] = ratingCount;
    data['product_code'] = productCode;
    data['total_amount'] = totalAmount;
    data['product_note'] = productNote;
    data['outofstock'] = outofstock;
    data['approval_status'] = approvalStatus;
    data['approved_by'] = approvedBy;
    data['approved_at'] = approvedAt;
    data['rejection_reason'] = rejectionReason;
    data['approval_notes'] = approvalNotes;
    data['stock_qty'] = stockQty;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['product_sub_category_id'] = productSubCategoryId;
    data['warehouse_type'] = warehouseType;
    data['stock_yard_address'] = stockYardAddress;
    data['main_category_name'] = mainCategoryName;
    data['sub_category_name'] = subCategoryName;
    data['category_product_name'] = categoryProductName;
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
