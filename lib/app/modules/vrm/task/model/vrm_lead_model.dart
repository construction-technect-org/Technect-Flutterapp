class VrmAllLeadModel {
  bool? success;
  String? message;
  VrmAllLeads? data;

  VrmAllLeadModel({this.success, this.message, this.data});

  VrmAllLeadModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? VrmAllLeads.fromJson(json['data']) : null;
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

class VrmAllLeads {
  List<VrmLead>? leads;
  VrmPagination? pagination;

  VrmAllLeads({this.leads, this.pagination});

  VrmAllLeads.fromJson(Map<String, dynamic> json) {
    if (json['leads'] != null) {
      leads = <VrmLead>[];
      json['leads'].forEach((v) {
        leads!.add(VrmLead.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? VrmPagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leads != null) {
      data['leads'] = leads!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class VrmLead {
  int? id;
  String? leadId;
  int? createdUserId;
  String? connectorName;
  String? connectorType;
  String? connectorId;
  String? connectorPhone;
  String? connectorProfileImage;
  String? productName;
  String? productCode;
  String? unitOfMeasure;
  String? quantity;
  String? estimateDeliveryDate;
  String? radius;
  String? leadStage;
  String? companyPhone;
  String? source;
  String? reference;
  String? referralPhone;
  String? siteLocation;
  String? siteLatitude;
  String? siteLongitude;
  String? companyName;
  String? gstNumber;
  String? companyAddress;
  bool? isAutoCreated;
  String? status;
  String? notes;
  int? assignedToUserId;
  String? reminderAt;
  int? qualifiedByUserId;
  String? qualifiedAt;
  String? createdAt;
  String? updatedAt;
  bool? assignedToSelf;
  int? assignedTeamMemberId;
  String? teamMemberNote;
  String? teamMemberPriority;
  String? lastConversation;
  String? nextConversation;
  int? merchantProfileId;
  String? merchantName;
  String? merchantProfileImageUrl;

  // Main stage fields
  String? mainStage;
  String? currentStage;
  String? currentStatus;

  // Sales fields
  int? salesLeadId;
  String? salesId;
  String? salesLeadsStage;
  String? salesLeadStatus;

  // Account fields
  int? accountLeadId;
  String? accountId;
  String? accountLeadsStage;
  String? accountLeadStatus;

  VrmLead({
    this.id,
    this.leadId,
    this.createdUserId,
    this.connectorName,
    this.connectorType,
    this.connectorId,
    this.connectorPhone,
    this.connectorProfileImage,
    this.productName,
    this.productCode,
    this.unitOfMeasure,
    this.quantity,
    this.estimateDeliveryDate,
    this.radius,
    this.leadStage,
    this.companyPhone,
    this.source,
    this.reference,
    this.referralPhone,
    this.siteLocation,
    this.siteLatitude,
    this.siteLongitude,
    this.companyName,
    this.gstNumber,
    this.companyAddress,
    this.isAutoCreated,
    this.status,
    this.notes,
    this.assignedToUserId,
    this.reminderAt,
    this.qualifiedByUserId,
    this.qualifiedAt,
    this.createdAt,
    this.updatedAt,
    this.assignedToSelf,
    this.assignedTeamMemberId,
    this.teamMemberNote,
    this.teamMemberPriority,
    this.lastConversation,
    this.nextConversation,
    this.merchantProfileId,
    this.merchantName,
    this.merchantProfileImageUrl,
    this.mainStage,
    this.currentStage,
    this.currentStatus,
    this.salesLeadId,
    this.salesId,
    this.salesLeadsStage,
    this.salesLeadStatus,
    this.accountLeadId,
    this.accountId,
    this.accountLeadsStage,
    this.accountLeadStatus,
  });

  VrmLead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['lead_id'];
    createdUserId = json['created_user_id'];
    connectorName = json['connector_name'];
    connectorType = json['connector_type'];
    connectorId = json['connector_id'];
    connectorPhone = json['connector_phone'];
    connectorProfileImage = json['connector_profile_image'];
    productName = json['product_name'];
    productCode = json['product_code'];
    unitOfMeasure = json['unit_of_measure'];
    quantity = json['quantity'];
    estimateDeliveryDate = json['estimate_delivery_date'];
    radius = json['radius'];
    leadStage = json['lead_stage'];
    companyPhone = json['company_phone'];
    source = json['source'];
    reference = json['reference'];
    referralPhone = json['referral_phone'];
    siteLocation = json['site_location'];
    siteLatitude = json['site_latitude']?.toString();
    siteLongitude = json['site_longitude']?.toString();
    companyName = json['company_name'];
    gstNumber = json['gst_number'];
    companyAddress = json['company_address'];
    isAutoCreated = json['is_auto_created'];
    status = json['status'];
    notes = json['notes'];
    assignedToUserId = json['assigned_to_user_id'];
    reminderAt = json['reminder_at'];
    qualifiedByUserId = json['qualified_by_user_id'];
    qualifiedAt = json['qualified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    assignedToSelf = json['assigned_to_self'];
    assignedTeamMemberId = json['assigned_team_member_id'];
    teamMemberNote = json['team_member_note'];
    teamMemberPriority = json['team_member_priority'];
    lastConversation = json['last_conversation'];
    nextConversation = json['next_conversation'];
    merchantProfileId = json['merchant_profile_id'];
    merchantName = json['merchant_name'];
    merchantProfileImageUrl = json['merchant_profile_image_url'];
    mainStage = json['main_stage'];
    currentStage = json['current_stage'];
    currentStatus = json['current_status'];
    salesLeadId = json['sales_lead_id'];
    salesId = json['sales_id'];
    salesLeadsStage = json['sales_leads_stage'];
    salesLeadStatus = json['sales_lead_status'];
    accountLeadId = json['account_lead_id'];
    accountId = json['account_id'];
    accountLeadsStage = json['account_leads_stage'];
    accountLeadStatus = json['account_lead_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lead_id'] = leadId;
    data['created_user_id'] = createdUserId;
    data['connector_name'] = connectorName;
    data['connector_type'] = connectorType;
    data['connector_id'] = connectorId;
    data['connector_phone'] = connectorPhone;
    data['connector_profile_image'] = connectorProfileImage;
    data['product_name'] = productName;
    data['product_code'] = productCode;
    data['unit_of_measure'] = unitOfMeasure;
    data['quantity'] = quantity;
    data['estimate_delivery_date'] = estimateDeliveryDate;
    data['radius'] = radius;
    data['lead_stage'] = leadStage;
    data['company_phone'] = companyPhone;
    data['source'] = source;
    data['reference'] = reference;
    data['referral_phone'] = referralPhone;
    data['site_location'] = siteLocation;
    data['site_latitude'] = siteLatitude;
    data['site_longitude'] = siteLongitude;
    data['company_name'] = companyName;
    data['gst_number'] = gstNumber;
    data['company_address'] = companyAddress;
    data['is_auto_created'] = isAutoCreated;
    data['status'] = status;
    data['notes'] = notes;
    data['assigned_to_user_id'] = assignedToUserId;
    data['reminder_at'] = reminderAt;
    data['qualified_by_user_id'] = qualifiedByUserId;
    data['qualified_at'] = qualifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['assigned_to_self'] = assignedToSelf;
    data['assigned_team_member_id'] = assignedTeamMemberId;
    data['team_member_note'] = teamMemberNote;
    data['team_member_priority'] = teamMemberPriority;
    data['last_conversation'] = lastConversation;
    data['next_conversation'] = nextConversation;
    data['merchant_profile_id'] = merchantProfileId;
    data['merchant_name'] = merchantName;
    data['merchant_profile_image_url'] = merchantProfileImageUrl;
    data['main_stage'] = mainStage;
    data['current_stage'] = currentStage;
    data['current_status'] = currentStatus;
    data['sales_lead_id'] = salesLeadId;
    data['sales_id'] = salesId;
    data['sales_leads_stage'] = salesLeadsStage;
    data['sales_lead_status'] = salesLeadStatus;
    data['account_lead_id'] = accountLeadId;
    data['account_id'] = accountId;
    data['account_leads_stage'] = accountLeadsStage;
    data['account_lead_status'] = accountLeadStatus;
    return data;
  }
}

class VrmPagination {
  int? currentPage;
  int? totalPages;
  int? totalLeads;
  int? limit;

  VrmPagination({this.currentPage, this.totalPages, this.totalLeads, this.limit});

  VrmPagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalLeads = json['totalLeads'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['totalLeads'] = totalLeads;
    data['limit'] = limit;
    return data;
  }
}
