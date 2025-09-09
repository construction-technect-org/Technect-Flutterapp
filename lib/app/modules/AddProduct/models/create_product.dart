// To parse this JSON data, do
//
//     final createProductModel = createProductModelFromJson(jsonString);

import 'dart:convert';

CreateProductModel createProductModelFromJson(String str) => CreateProductModel.fromJson(json.decode(str));

String createProductModelToJson(CreateProductModel data) => json.encode(data.toJson());

class CreateProductModel {
  final bool? success;
  final CreateProductData? data;
  final String? message;

  CreateProductModel({
    this.success,
    this.data,
    this.message,
  });

  factory CreateProductModel.fromJson(Map<String, dynamic> json) => CreateProductModel(
    success: json["success"],
    data: json["data"] == null ? null : CreateProductData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class CreateProductData {
  final int? id;
  final int? merchantProfileId;
  final String? productName;
  final dynamic productImage;
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
  final bool? isActive;
  final bool? isFeatured;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? mainCategoryName;
  final String? subCategoryName;
  final String? categoryProductName;
  final String? filterValues;

  CreateProductData({
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
    this.isActive,
    this.isFeatured,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.mainCategoryName,
    this.subCategoryName,
    this.categoryProductName,
    this.filterValues,
  });

  factory CreateProductData.fromJson(Map<String, dynamic> json) => CreateProductData(
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
    isActive: json["is_active"],
    isFeatured: json["is_featured"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "is_active": isActive,
    "is_featured": isFeatured,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "main_category_name": mainCategoryName,
    "sub_category_name": subCategoryName,
    "category_product_name": categoryProductName,
    "filter_values": filterValues,
  };
}
