class AllLeadModel {
  bool? success;
  String? message;
  AllLeads? data;

  AllLeadModel({this.success, this.message, this.data});

  AllLeadModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? AllLeads.fromJson(json['data']) : null;
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

class AllLeads {
  List<Leads>? leads;
  Pagination? pagination;

  AllLeads({this.leads, this.pagination});

  AllLeads.fromJson(Map<String, dynamic> json) {
    if (json['leads'] != null) {
      leads = <Leads>[];
      json['leads'].forEach((v) {
        leads!.add(Leads.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
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

class Leads {
  int? id;
  String? leadId;

  int? createdUserId;

  String? connectorName;
  String? image;
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
  double? distanceKM;

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

  AssignedTeamMember? assignedTeamMember;
  AssignedUser? assignedUser;

  String? salesLeadStage;

  Leads({
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
    this.image,
    this.quantity,
    this.distanceKM,
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
    this.assignedTeamMember,
    this.salesLeadStage,
    this.assignedUser,
  });

  Leads.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    leadId = json["lead_id"];
    createdUserId = json["created_user_id"];
    image = json["image"];

    connectorName = json["connector_name"];
    connectorType = json["connector_type"];
    connectorId = json["connector_id"];
    connectorPhone = json["connector_phone"];
    connectorProfileImage = json["connector_profile_image"];

    productName = json["product_name"];
    productCode = json["product_code"];
    unitOfMeasure = json["unit_of_measure"];
    quantity = json["quantity"];
    estimateDeliveryDate = json["estimate_delivery_date"];
    radius = json["radius"];
    distanceKM = json["distance_km"];

    leadStage = json["lead_stage"];
    companyPhone = json["company_phone"];
    source = json["source"];
    reference = json["reference"];
    referralPhone = json["referral_phone"];

    siteLocation = json["site_location"];
    siteLatitude = json["site_latitude"]?.toString();
    siteLongitude = json["site_longitude"]?.toString();

    companyName = json["company_name"];
    gstNumber = json["gst_number"];
    companyAddress = json["company_address"];

    isAutoCreated = json["is_auto_created"];
    status = json["status"];
    notes = json["notes"];

    assignedToUserId = json["assigned_to_user_id"];
    reminderAt = json["reminder_at"];
    qualifiedByUserId = json["qualified_by_user_id"];
    qualifiedAt = json["qualified_at"];

    createdAt = json["created_at"];
    updatedAt = json["updated_at"];

    assignedToSelf = json["assigned_to_self"];
    assignedTeamMemberId = json["assigned_team_member_id"];
    teamMemberNote = json["team_member_note"];
    teamMemberPriority = json["team_member_priority"];

    lastConversation = json["last_conversation"];
    nextConversation = json["next_conversation"];


    salesLeadStage = json["sales_leads_stage"];

    assignedTeamMember = json["assigned_team_member"] != null
        ? AssignedTeamMember.fromJson(json["assigned_team_member"])
        : null;

    assignedUser = json["assigned_user"] != null
        ? AssignedUser.fromJson(json["assigned_user"])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "lead_id": leadId,
      "created_user_id": createdUserId,
      "connector_name": connectorName,
      "connector_type": connectorType,
      "connector_id": connectorId,
      "connector_phone": connectorPhone,
      "connector_profile_image": connectorProfileImage,
      "product_name": productName,
      "product_code": productCode,
      "unit_of_measure": unitOfMeasure,
      "quantity": quantity,
      "estimate_delivery_date": estimateDeliveryDate,
      "radius": radius,
      "lead_stage": leadStage,
      "company_phone": companyPhone,
      "source": source,
      "distance_km": distanceKM,
      "reference": reference,
      "referral_phone": referralPhone,
      "site_location": siteLocation,
      "site_latitude": siteLatitude,
      "site_longitude": siteLongitude,
      "company_name": companyName,
      "gst_number": gstNumber,
      "company_address": companyAddress,
      "is_auto_created": isAutoCreated,
      "status": status,
      "notes": notes,
      "assigned_to_user_id": assignedToUserId,
      "reminder_at": reminderAt,
      "qualified_by_user_id": qualifiedByUserId,
      "qualified_at": qualifiedAt,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "assigned_to_self": assignedToSelf,
      "assigned_team_member_id": assignedTeamMemberId,
      "team_member_note": teamMemberNote,
      "team_member_priority": teamMemberPriority,
      "last_conversation": lastConversation,
      "next_conversation": nextConversation,
      "assigned_team_member": assignedTeamMember?.toJson(),
      "assigned_user": assignedUser?.toJson(),
    };
  }
}

class AssignedTeamMember {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? profilePhoto;
  int? teamRoleId;
  String? roleTitle;

  AssignedTeamMember({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.profilePhoto,
    this.teamRoleId,
    this.roleTitle,
  });

  AssignedTeamMember.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    mobileNumber = json["mobileNumber"];
    profilePhoto = json["profilePhoto"];
    teamRoleId = json["teamRoleId"];
    roleTitle = json["roleTitle"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "mobileNumber": mobileNumber,
      "profilePhoto": profilePhoto,
      "teamRoleId": teamRoleId,
      "roleTitle": roleTitle,
    };
  }
}

class AssignedUser {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? countryCode;
  String? profileImage;
  String? roleName;

  AssignedUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.countryCode,
    this.profileImage,
    this.roleName,
  });

  AssignedUser.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    mobileNumber = json["mobileNumber"];
    countryCode = json["countryCode"];
    profileImage = json["profileImage"];
    roleName = json["roleName"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "mobileNumber": mobileNumber,
      "countryCode": countryCode,
      "profileImage": profileImage,
      "roleName": roleName,
    };
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalLeads;
  int? limit;
  bool? hasNext;
  bool? hasPrev;

  Pagination(
      {this.currentPage,
        this.totalPages,
        this.totalLeads,
        this.limit,
        this.hasNext,
        this.hasPrev});

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

