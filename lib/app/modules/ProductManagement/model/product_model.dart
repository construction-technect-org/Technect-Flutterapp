// To parse this JSON data, do
//
//     final getFilterModel = getFilterModelFromJson(jsonString);

import 'dart:convert';

ProductListModel getFilterModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String getFilterModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  final bool? success;
  final Data? data;
  final String? message;

  ProductListModel({
    this.success,
    this.data,
    this.message,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
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

  Data({
    this.products,
    this.statistics,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    statistics: json["statistics"] == null ? null : Statistics.fromJson(json["statistics"]),
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
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
  final String? brand;
  final String? uom;
  final String? packageType;
  final String? packageSize;
  final String? shape;
  final String? texture;
  final String? colour;
  final String? size;
  final String? weight;
  final String? price;
  final String? gstPercentage;
  final String? gstAmount;
  final String? termsAndConditions;
  final bool? isActive;
  final bool? isFeatured;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? stockQuantity;
  final String? stockStatus;
  final int? lowStockThreshold;
  final String? averageRating;
  final int? totalRatings;
  final int? ratingCount;
  final String? mainCategoryName;
  final String? subCategoryName;
  final String? categoryProductName;
  final String? filterValues;

  Product({
    this.id,
    this.merchantProfileId,
    this.productName,
    this.productImage,
    this.mainCategoryId,
    this.subCategoryId,
    this.categoryProductId,
    this.brand,
    this.uom,
    this.packageType,
    this.packageSize,
    this.shape,
    this.texture,
    this.colour,
    this.size,
    this.weight,
    this.price,
    this.gstPercentage,
    this.gstAmount,
    this.termsAndConditions,
    this.isActive,
    this.isFeatured,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.stockQuantity,
    this.stockStatus,
    this.lowStockThreshold,
    this.averageRating,
    this.totalRatings,
    this.ratingCount,
    this.mainCategoryName,
    this.subCategoryName,
    this.categoryProductName,
    this.filterValues,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    merchantProfileId: json["merchant_profile_id"],
    productName: json["product_name"],
    productImage: json["product_image"],
    mainCategoryId: json["main_category_id"],
    subCategoryId: json["sub_category_id"],
    categoryProductId: json["category_product_id"],
    brand: json["brand"],
    uom: json["uom"],
    packageType: json["package_type"],
    packageSize: json["package_size"],
    shape: json["shape"],
    texture: json["texture"],
    colour: json["colour"],
    size: json["size"],
    weight: json["weight"],
    price: json["price"],
    gstPercentage: json["gst_percentage"],
    gstAmount: json["gst_amount"],
    termsAndConditions: json["terms_and_conditions"],
    isActive: json["is_active"],
    isFeatured: json["is_featured"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    stockQuantity: json["stock_quantity"],
    stockStatus: json["stock_status"],
    lowStockThreshold: json["low_stock_threshold"],
    averageRating: json["average_rating"],
    totalRatings: json["total_ratings"],
    ratingCount: json["rating_count"],
    mainCategoryName: json["main_category_name"],
    subCategoryName: json["sub_category_name"],
    categoryProductName: json["category_product_name"],
    filterValues: json["filter_values"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_profile_id": merchantProfileId,
    "product_name": productName,
    "product_image": productImage,
    "main_category_id": mainCategoryId,
    "sub_category_id": subCategoryId,
    "category_product_id": categoryProductId,
    "brand": brand,
    "uom": uom,
    "package_type": packageType,
    "package_size": packageSize,
    "shape": shape,
    "texture": texture,
    "colour": colour,
    "size": size,
    "weight": weight,
    "price": price,
    "gst_percentage": gstPercentage,
    "gst_amount": gstAmount,
    "terms_and_conditions": termsAndConditions,
    "is_active": isActive,
    "is_featured": isFeatured,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "stock_quantity": stockQuantity,
    "stock_status": stockStatus,
    "low_stock_threshold": lowStockThreshold,
    "average_rating": averageRating,
    "total_ratings": totalRatings,
    "rating_count": ratingCount,
    "main_category_name": mainCategoryName,
    "sub_category_name": subCategoryName,
    "category_product_name": categoryProductName,
    "filter_values": filterValues,
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
    lowStock: json["low_stock"],
    totalInterests: json["total_interests"],
    featured: json["featured"],
  );

  Map<String, dynamic> toJson() => {
    "total_products": totalProducts,
    "low_stock": lowStock,
    "total_interests": totalInterests,
    "featured": featured,
  };
}
