class LeadModel {
  final String id;
  final String name;
  final String connector;
  final String product;
  final Status status;
  final double distanceKm;
  final DateTime dateTime;
  final String avatarUrl;

  LeadModel({
    required this.id,
    required this.name,
    required this.connector,
    required this.product,
    required this.distanceKm,
    required this.dateTime,
    this.status = Status.pending,
    required this.avatarUrl,
  });
}

enum Status {
  pending('Pending'),
  completed('Completed'),
  missed('Missed'),
  closed('Closed');

  final String text;
  const Status(this.text);
}

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
  String? customerName;
  String? customerType;
  String? customerId;
  String? customerPhone;
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
  String? companyName;
  String? gstNumber;
  String? companyAddress;
  int? createdBy;
  bool? isAutoCreated;
  String? status;
  String? notes;
  String? createdAt;
  String? updatedAt;

  Leads(
      {this.id,
        this.leadId,
        this.customerName,
        this.customerType,
        this.customerId,
        this.customerPhone,
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
        this.companyName,
        this.gstNumber,
        this.companyAddress,
        this.createdBy,
        this.isAutoCreated,
        this.status,
        this.notes,
        this.createdAt,
        this.updatedAt});

  Leads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['lead_id'];
    customerName = json['customer_name'];
    customerType = json['customer_type'];
    customerId = json['customer_id'];
    customerPhone = json['customer_phone'];
    productName = json['product_name'];
    productCode = json['product_code'];
    unitOfMeasure = json['unit_of_measure'];
    quantity = json['quantity'];
    estimateDeliveryDate = json['estimate_delivery_date'];
    radius = json['radius'];
    companyPhone = json['company_phone'];
    source = json['source'];
    reference = json['reference'];
    referralPhone = json['referral_phone'];
    siteLocation = json['site_location'];
    companyName = json['company_name'];
    gstNumber = json['gst_number'];
    companyAddress = json['company_address'];
    createdBy = json['created_by'];
    isAutoCreated = json['is_auto_created'];
    status = json['status'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lead_id'] = leadId;
    data['customer_name'] = customerName;
    data['customer_type'] = customerType;
    data['customer_id'] = customerId;
    data['customer_phone'] = customerPhone;
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
    data['company_name'] = companyName;
    data['gst_number'] = gstNumber;
    data['company_address'] = companyAddress;
    data['created_by'] = createdBy;
    data['is_auto_created'] = isAutoCreated;
    data['status'] = status;
    data['notes'] = notes;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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

