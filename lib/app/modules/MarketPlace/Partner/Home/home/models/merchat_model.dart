class AllMerchantStoreModel {
  bool? success;
  String? message;
  MerchantStore? data;

  AllMerchantStoreModel({this.success, this.message, this.data});

  AllMerchantStoreModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? MerchantStore.fromJson(json['data']) : null;
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

class MerchantStore {
  List<Stores>? stores;
  Pagination? pagination;

  MerchantStore({this.stores, this.pagination});

  MerchantStore.fromJson(Map<String, dynamic> json) {
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Stores {
  int? merchantProfileId;
  String? businessName;
  String? businessEmail;
  String? businessContactNumber;
  String? merchantGstNumber;
  String? ownerName;
  String? ownerProfileImage;
  String? totalProducts;
  String? approvedProducts;

  Stores(
      {this.merchantProfileId,
        this.businessName,
        this.businessEmail,
        this.businessContactNumber,
        this.merchantGstNumber,
        this.ownerName,
        this.ownerProfileImage,
        this.totalProducts,
        this.approvedProducts});

  Stores.fromJson(Map<String, dynamic> json) {
    merchantProfileId = json['merchant_profile_id'];
    businessName = json['business_name'];
    businessEmail = json['business_email'];
    businessContactNumber = json['business_contact_number'];
    merchantGstNumber = json['merchant_gst_number'];
    ownerName = json['owner_name'];
    ownerProfileImage = json['owner_profile_image'];
    totalProducts = json['total_products'];
    approvedProducts = json['approved_products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['merchant_profile_id'] = merchantProfileId;
    data['business_name'] = businessName;
    data['business_email'] = businessEmail;
    data['business_contact_number'] = businessContactNumber;
    data['merchant_gst_number'] = merchantGstNumber;
    data['owner_name'] = ownerName;
    data['owner_profile_image'] = ownerProfileImage;
    data['total_products'] = totalProducts;
    data['approved_products'] = approvedProducts;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalStores;
  int? limit;
  bool? hasNext;
  bool? hasPrev;

  Pagination(
      {this.currentPage,
        this.totalPages,
        this.totalStores,
        this.limit,
        this.hasNext,
        this.hasPrev});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    totalStores = json['total_stores'];
    limit = json['limit'];
    hasNext = json['has_next'];
    hasPrev = json['has_prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    data['total_stores'] = totalStores;
    data['limit'] = limit;
    data['has_next'] = hasNext;
    data['has_prev'] = hasPrev;
    return data;
  }
}
