import 'package:construction_technect/app/modules/CRM/dashboard/marketing/model/lead_model.dart';

class AllAccountsModel {
  bool? success;
  String? message;
  AllAccounts? data;

  AllAccountsModel({this.success, this.message, this.data});

  AllAccountsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? AllAccounts.fromJson(json['data']) : null;
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

class AllAccounts {
  List<AccountLeads>? leads;
  Pagination? pagination;

  AllAccounts({this.leads, this.pagination});

  AllAccounts.fromJson(Map<String, dynamic> json) {
    if (json['leads'] != null) {
      leads = <AccountLeads>[];
      json['leads'].forEach((v) {
        leads!.add(AccountLeads.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
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

class AccountLeads {
  int? salesLeadId;
  String? salesId;
  String? leadIdString;
  String? salesLeadsStage;
  String? status;
  int? assignedToUserId;
  bool? assignedToSelf;
  int? assignedTeamMemberId;
  String? teamMemberNote;
  String? teamMemberPriority;
  String? reminderAt;
  int? qualifiedByUserId;
  String? qualifiedAt;
  String? lastConversation;
  String? nextConversation;
  String? salesLeadCreatedAt;
  String? salesLeadUpdatedAt;
  int? id;
  String? leadId;
  int? createdUserId;
  String? connectorName;
  String? connectorType;
  String? saleStatus;
  String? connectorId;
  String? connectorPhone;
  String? connectorProfileImage;
  String? productName;
  String? productCode;
  String? unitOfMeasure;
  String? quantity;
  String? estimateDeliveryDate;
  String? radius;
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
  String? notes;
  String? createdAt;
  double? distanceKm;
  String? updatedAt;
  String? salesLeadsStageDisplay;

  AssignedTeamMember? assignedTeamMember;

  // ✅ Newly Added Fields
  int? productId;
  int? serviceId;
  int? groupId;
  String? groupName;
  String? merchantLogo;
  int? merchantUserId;

  AccountLeads({
    this.salesLeadId,
    this.salesId,
    this.leadIdString,
    this.salesLeadsStage,
    this.status,
    this.assignedToUserId,
    this.assignedToSelf,
    this.assignedTeamMemberId,
    this.teamMemberNote,
    this.teamMemberPriority,
    this.reminderAt,
    this.qualifiedByUserId,
    this.qualifiedAt,
    this.lastConversation,
    this.nextConversation,
    this.salesLeadCreatedAt,
    this.salesLeadUpdatedAt,
    this.id,
    this.leadId,
    this.createdUserId,
    this.saleStatus,
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
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.distanceKm,
    this.salesLeadsStageDisplay,
    this.assignedTeamMember,

    // Newly Added fields
    this.productId,
    this.serviceId,
    this.groupId,
    this.groupName,
    this.merchantLogo,
    this.merchantUserId,
  });

  AccountLeads.fromJson(Map<String, dynamic> json) {
    salesLeadId = json['sales_lead_id'];
    salesId = json['sales_id'];
    leadIdString = json['lead_id_string'];
    salesLeadsStage = json['sales_leads_stage'];
    status = json['status'];
    assignedToUserId = json['assigned_to_user_id'];
    assignedToSelf = json['assigned_to_self'];
    assignedTeamMemberId = json['assigned_team_member_id'];
    teamMemberNote = json['team_member_note'];
    teamMemberPriority = json['team_member_priority'];
    reminderAt = json['reminder_at'];
    qualifiedByUserId = json['qualified_by_user_id'];
    qualifiedAt = json['qualified_at'];
    lastConversation = json['last_conversation'];
    nextConversation = json['next_conversation'];
    salesLeadCreatedAt = json['sales_lead_created_at'];
    salesLeadUpdatedAt = json['sales_lead_updated_at'];
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
    saleStatus = json['sales_status'];
    estimateDeliveryDate = json['estimate_delivery_date'];
    radius = json['radius'];
    companyPhone = json['company_phone'];
    source = json['source'];
    reference = json['reference'];
    referralPhone = json['referral_phone'];
    siteLocation = json['site_location'];
    siteLatitude = json['site_latitude'];
    siteLongitude = json['site_longitude'];
    companyName = json['company_name'];
    gstNumber = json['gst_number'];
    companyAddress = json['company_address'];
    isAutoCreated = json['is_auto_created'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    distanceKm = json['distance_km'];
    salesLeadsStageDisplay = json['sales_leads_stage_display'];

    assignedTeamMember = json["assigned_team_member"] != null
        ? AssignedTeamMember.fromJson(json["assigned_team_member"])
        : null;

    // ✅ Newly added fields
    productId = json['product_id'];
    serviceId = json['service_id'];
    groupId = json['group_id'];
    groupName = json['group_name'];
    merchantLogo = json['merchant_logo'];
    merchantUserId = json['merchant_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['sales_lead_id'] = salesLeadId;
    data['sales_id'] = salesId;
    data['lead_id_string'] = leadIdString;
    data['sales_leads_stage'] = salesLeadsStage;
    data['status'] = status;
    data['assigned_to_user_id'] = assignedToUserId;
    data['assigned_to_self'] = assignedToSelf;
    data['assigned_team_member_id'] = assignedTeamMemberId;
    data['team_member_note'] = teamMemberNote;
    data['team_member_priority'] = teamMemberPriority;
    data['reminder_at'] = reminderAt;
    data['qualified_by_user_id'] = qualifiedByUserId;
    data['qualified_at'] = qualifiedAt;
    data['last_conversation'] = lastConversation;
    data['next_conversation'] = nextConversation;
    data['sales_lead_created_at'] = salesLeadCreatedAt;
    data['sales_lead_updated_at'] = salesLeadUpdatedAt;
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
    data['notes'] = notes;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['distance_km'] = distanceKm;
    data['sales_status'] = saleStatus;
    data['sales_leads_stage_display'] = salesLeadsStageDisplay;
    data["assigned_team_member"] = assignedTeamMember?.toJson();

    // ✅ Newly added fields
    data['product_id'] = productId;
    data['service_id'] = serviceId;
    data['group_id'] = groupId;
    data['group_name'] = groupName;
    data['merchant_logo'] = merchantLogo;
    data['merchant_user_id'] = merchantUserId;

    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalLeads;
  int? limit;
  bool? hasNext;
  bool? hasPrev;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalLeads,
    this.limit,
    this.hasNext,
    this.hasPrev,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalLeads = json['totalLeads'];
    limit = json['limit'];
    hasNext = json['hasNext'];
    hasPrev = json['hasPrev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['totalLeads'] = totalLeads;
    data['limit'] = limit;
    data['hasNext'] = hasNext;
    data['hasPrev'] = hasPrev;
    return data;
  }
}
