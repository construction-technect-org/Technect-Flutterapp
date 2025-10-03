class SubCategoryModel {
  bool? success;
  List<SubCategory>? data;
  String? message;

  SubCategoryModel({this.success, this.data, this.message});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<SubCategory>.from(json["data"]!.map((x) => SubCategory.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class SubCategory {
  int? id;
  int? mainCategoryId;
  String? name;
  bool? isActive;
  int? sortOrder;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? mainCategoryName;

  SubCategory({
    this.id,
    this.mainCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.mainCategoryName,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    mainCategoryId: json["main_category_id"],
    name: json["name"],
    isActive: json["is_active"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    mainCategoryName: json["main_category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main_category_id": mainCategoryId,
    "name": name,
    "is_active": isActive,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "main_category_name": mainCategoryName,
  };
}
