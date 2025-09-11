class ProductModel {
  bool? success;
  List<CategoryProduct>? data;
  String? message;

  ProductModel({this.success, this.data, this.message});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<CategoryProduct>.from(
            json["data"]!.map((x) => CategoryProduct.fromJson(x)),
          ),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class CategoryProduct {
  int? id;
  int? subCategoryId;
  String? name;
  bool? isActive;
  int? sortOrder;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? subCategoryName;

  CategoryProduct({
    this.id,
    this.subCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.subCategoryName,
  });

  factory CategoryProduct.fromJson(Map<String, dynamic> json) => CategoryProduct(
    id: json["id"],
    subCategoryId: json["sub_category_id"],
    name: json["name"],
    isActive: json["is_active"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subCategoryName: json["sub_category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_category_id": subCategoryId,
    "name": name,
    "is_active": isActive,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "sub_category_name": subCategoryName,
  };
}
