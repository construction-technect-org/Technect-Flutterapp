class InventoryProductModel {
  bool? success;
  String? message;
  InventoryProductData? data;

  InventoryProductModel({this.success, this.message, this.data});

  InventoryProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? InventoryProductData.fromJson(json['data']) : null;
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

class InventoryProductData {
  int? id;
  int? merchantProfileId;
  int? mainCategoryId;
  int? subCategoryId;
  int? categoryProductId;
  int? productSubCategoryId;
  String? brand;
  String? price;
  String? gstPercentage;
  String? totalAmount;
  String? warehouseType;
  String? stockYardAddress;
  String? productNote;
  String? termsAndConditions;
  int? stockQty;
  bool? outofstock;
  bool? isFeatured;
  String? sortOrder;
  String? approvalStatus;
  String? createdAt;
  String? updatedAt;
  List<ProductMedia>? images;
  ProductMedia? video;

  InventoryProductData({
    this.id,
    this.merchantProfileId,
    this.mainCategoryId,
    this.subCategoryId,
    this.categoryProductId,
    this.productSubCategoryId,
    this.brand,
    this.price,
    this.gstPercentage,
    this.totalAmount,
    this.warehouseType,
    this.stockYardAddress,
    this.productNote,
    this.termsAndConditions,
    this.stockQty,
    this.outofstock,
    this.isFeatured,
    this.sortOrder,
    this.approvalStatus,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.video,
  });

  InventoryProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantProfileId = json['merchant_profile_id'];
    mainCategoryId = json['main_category_id'];
    subCategoryId = json['sub_category_id'];
    categoryProductId = json['category_product_id'];
    productSubCategoryId = json['product_sub_category_id'];
    brand = json['brand'];
    price = json['price']?.toString();
    gstPercentage = json['gst_percentage']?.toString();
    totalAmount = json['total_amount']?.toString();
    warehouseType = json['warehouse_type'];
    stockYardAddress = json['stock_yard_address'];
    productNote = json['product_note'];
    termsAndConditions = json['terms_and_conditions'];
    stockQty = json['stock_qty'];
    outofstock = json['outofstock'];
    isFeatured = json['is_featured'];
    sortOrder = json['sort_order']?.toString();
    approvalStatus = json['approval_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['images'] != null) {
      images = <ProductMedia>[];
      json['images'].forEach((v) {
        images!.add(ProductMedia.fromJson(v));
      });
    }
    video = json['video'] != null ? ProductMedia.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_profile_id'] = merchantProfileId;
    data['main_category_id'] = mainCategoryId;
    data['sub_category_id'] = subCategoryId;
    data['category_product_id'] = categoryProductId;
    data['product_sub_category_id'] = productSubCategoryId;
    data['brand'] = brand;
    data['price'] = price;
    data['gst_percentage'] = gstPercentage;
    data['total_amount'] = totalAmount;
    data['warehouse_type'] = warehouseType;
    data['stock_yard_address'] = stockYardAddress;
    data['product_note'] = productNote;
    data['terms_and_conditions'] = termsAndConditions;
    data['stock_qty'] = stockQty;
    data['outofstock'] = outofstock;
    data['is_featured'] = isFeatured;
    data['sort_order'] = sortOrder;
    data['approval_status'] = approvalStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (video != null) {
      data['video'] = video!.toJson();
    }
    return data;
  }
}

class ProductMedia {
  int? id;
  String? mediaType;
  String? mediaUrl;
  String? mediaS3Key;
  int? sortOrder;
  String? createdAt;

  ProductMedia({
    this.id,
    this.mediaType,
    this.mediaUrl,
    this.mediaS3Key,
    this.sortOrder,
    this.createdAt,
  });

  ProductMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaType = json['media_type'];
    mediaUrl = json['media_url'];
    mediaS3Key = json['media_s3_key'];
    sortOrder = json['sort_order'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['media_type'] = mediaType;
    data['media_url'] = mediaUrl;
    data['media_s3_key'] = mediaS3Key;
    data['sort_order'] = sortOrder;
    data['created_at'] = createdAt;
    return data;
  }
}
