// To parse this JSON data, do
//
//     final getFilterModel = getFilterModelFromJson(jsonString);

import 'dart:convert';

import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';

ProductListModel getFilterModelFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String getFilterModelToJson(ProductListModel data) =>
    json.encode(data.toJson());

class ProductImage {
  final String? s3Key;
  final String? s3Url;
  final int? sortOrder;

  ProductImage({this.s3Key, this.s3Url, this.sortOrder});

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    s3Key: json["s3_key"],
    s3Url: json["s3_url"],
    sortOrder: json["sort_order"],
  );

  Map<String, dynamic> toJson() => {
    "s3_key": s3Key,
    "s3_url": s3Url,
    "sort_order": sortOrder,
  };
}

class ProductListModel {
  final bool? success;
  final Data? data;
  final String? message;

  ProductListModel({this.success, this.data, this.message});

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),

        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final List<Product>? products;
  final Statistics? statistics;

  Data({this.products, this.statistics});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: json["products"] == null
        ? []
        : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    statistics: json["statistics"] == null
        ? null
        : Statistics.fromJson(json["statistics"]),
  );

  Map<String, dynamic> toJson() => {
    "products": products == null
        ? []
        : List<dynamic>.from(products!.map((x) => x.toJson())),
    "statistics": statistics?.toJson(),
  };
}

class Product {
  final int? id;
  final int? merchantProfileId;
  final String? productName;
  final String? productImage;
  final int? mainCategoryId;
  final int? subCategoryId;
  final int? categoryProductId;
  final int? productSubCategoryId;
  final String? brand;
  final String? uom;
  final String? packageType;
  final String? packageSize;
  final String? shape;
  final String? texture;
  final String? colour;
  final String? size;
  final String? price;
  final String? gstPercentage;
  final String? gstAmount;
  final String? termsAndConditions;
  final String? createdAt;
  final String? updatedAt;
  final String? averageRating;
  final int? totalRatings;
  final int? ratingCount;
  final String? productCode;
  final String? uoc;
  final String? totalAmount;
  final String? productNote;
  final String? address;
  final String? merchantLogo;
  final bool? outOfStock;
  final bool? isActive;
  final bool? isNotify;
  final String? status;
   bool? isInWishList;
  final String? approvalStatus;
  final String? mainCategoryName;
  final String? subCategoryName;
  final String? categoryProductName;
  final String? productSubCategoryName;
  final String? distanceKm;
  final String? merchantGstNumber;
  final String? productVideo;
  final int? stockQty;
  final Map<String, dynamic>? filterValues;
  final List<ProductImage>? images;
  final String? merchantName;
  final String? merchantEmail;
  final String? merchantPhone;
  final String? merchantWebsite;
  final String? warehouseType;
  final String? stockYardAddress;
  List<BusinessHours>? businessHours;


  Product({
    this.id,
    this.merchantProfileId,
    this.productName,
    this.productImage,
    this.isNotify,
    this.mainCategoryId,
    this.subCategoryId,
    this.productSubCategoryId,
    this.merchantName,
    this.merchantEmail,
    this.categoryProductId,
    this.merchantWebsite,
    this.brand,
    this.businessHours,
    this.productSubCategoryName,
    this.merchantPhone,
    this.merchantGstNumber,
    this.uom,
    this.packageType,
    this.merchantLogo,
    this.address,
    this.packageSize,
    this.isActive,
    this.isInWishList,
    this.shape,
    this.distanceKm,
    this.status,
    this.texture,
    this.colour,
    this.size,
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
    this.uoc,
    this.totalAmount,
    this.productNote,
    this.outOfStock,
    this.approvalStatus,
    this.mainCategoryName,
    this.subCategoryName,
    this.categoryProductName,
    this.stockQty,
    this.productVideo,
    this.filterValues,
    this.images,
    this.stockYardAddress,
    this.warehouseType,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      merchantProfileId: json["merchant_profile_id"],
      productName: json["product_name"],
      productImage: json["product_image"],
      mainCategoryId: json["main_category_id"],
      subCategoryId: json["sub_category_id"],
      categoryProductId: json["category_product_id"],
      productSubCategoryId: json["product_sub_category_id"],
      brand: json["brand"],
      uom: json["uom"],
      merchantLogo: json["merchant_logo"],
      isActive: json["isActive"],
      packageType: json["package_type"],
      packageSize: json["package_size"],
      shape: json["shape"],
      texture: json["texture"],
      colour: json["colour"],
      size: json["size"],
      distanceKm: json["distance_km"]!=null ?json["distance_km"].toString():"",
      price: json["price"],
      address: json["address"],
      gstPercentage: json["gst_percentage"],
      gstAmount: json["gst_amount"],
      termsAndConditions: json["terms_and_conditions"],
      productSubCategoryName: json["product_sub_category_name"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      averageRating: json["average_rating"],
      totalRatings: json["total_ratings"],
      ratingCount: json["rating_count"],
      productCode: json["product_code"],
      uoc: json["uoc"],
      totalAmount: json["total_amount"],
      productNote: json["product_note"],
      outOfStock: json["outofstock"],
      approvalStatus: json["approval_status"],
      mainCategoryName: json["main_category_name"],
      subCategoryName: json["sub_category_name"],
      categoryProductName: json["category_product_name"],
      stockQty: json["stock_qty"],
      status: json["connection_request_status"],
      isNotify: json["has_stock_notification"],
      isInWishList: json["is_in_wishlist"],
      productVideo: json["video"],
      merchantName: json["merchant_name"],
      merchantWebsite: json["merchant_website"],
      merchantEmail: json["merchant_email"],
      merchantGstNumber: json["merchant_gst_number"],
      warehouseType: json["warehouse_type"],
      stockYardAddress: json["stock_yard_address"],
      merchantPhone: json["merchant_phone"],
      businessHours: json["business_hours"] == null
          ? []
          : List<BusinessHours>.from(
        json["business_hours"]!.map((x) => BusinessHours.fromJson(x)),
      ),
      filterValues: json["filter_values"] != null
          ? Map<String, dynamic>.from(json["filter_values"])
          : null,
      images: json["images"] == null
          ? []
          : List<ProductImage>.from(
              json["images"].map((x) => ProductImage.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_profile_id": merchantProfileId,
    "product_name": productName,
    "product_image": productImage,
    "main_category_id": mainCategoryId,
    "sub_category_id": subCategoryId,
    "merchant_name": merchantName,
    "merchant_email": merchantEmail,
    "category_product_id": categoryProductId,
    "merchant_logo":  merchantLogo,
    "brand": brand,
    "stock_yard_address": stockYardAddress,
    "warehouse_type": warehouseType,
    "merchant_phone": merchantPhone,
    "uom": uom,
    "package_type": packageType,
    "merchant_website": merchantWebsite,
    "package_size": packageSize,
    "shape": shape,
    "isActive": isActive,
    "distance_km": distanceKm,
    "texture": texture,
    "colour": colour,
    "size": size,
    "price": price,
    "address": address,
    "gst_percentage": gstPercentage,
    "gst_amount": gstAmount,
    "terms_and_conditions": termsAndConditions,
    "created_at": createdAt,
    "merchant_gst_number": merchantGstNumber,
    "updated_at": updatedAt,
    "average_rating": averageRating,
    "total_ratings": totalRatings,
    "rating_count": ratingCount,
    "business_hours": businessHours == null
        ? []
        : List<dynamic>.from(businessHours!.map((x) => x.toJson())),
    "product_sub_category_name": productSubCategoryName,
    "product_code": productCode,
    "uoc": uoc,
    "total_amount": totalAmount,
    "product_sub_category_id": productSubCategoryId,
    "product_note": productNote,
    "outofstock": outOfStock,
    "approval_status": approvalStatus,
    "main_category_name": mainCategoryName,
    "sub_category_name": subCategoryName,
    "category_product_name": categoryProductName,
    "stock_qty": stockQty,
    "filter_values": filterValues,
    "connection_request_status": status,
    "has_stock_notification": isNotify,
    "is_in_wishlist": isInWishList,
    "video": productVideo,
    "images": images == null
        ? []
        : List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}

class Statistics {
  final int? totalProducts;
  final int? lowStock;
  final int? totalInterests;
  final int? featured;

  Statistics({
    this.totalProducts,
    this.lowStock,
    this.totalInterests,
    this.featured,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    totalProducts: json["total_products"],
    lowStock: json["out_of_stock"],
    totalInterests: json["total_interests"],
    featured: json["approved"],
  );

  Map<String, dynamic> toJson() => {
    "total_products": totalProducts,
    "out_of_stock": lowStock,
    "total_interests": totalInterests,
    "approved": featured,
  };
}
