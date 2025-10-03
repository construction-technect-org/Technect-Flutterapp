class MainCategoryModel {
  bool? success;
  List<MainCategory>? data;
  String? message;

  MainCategoryModel({this.success, this.data, this.message});

  factory MainCategoryModel.fromJson(Map<String, dynamic> json) => MainCategoryModel(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<MainCategory>.from(json["data"]!.map((x) => MainCategory.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class MainCategory {
  int? id;
  String? name;
  bool? isActive;
  int? sortOrder;
  DateTime? createdAt;
  DateTime? updatedAt;

  MainCategory({
    this.id,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
    id: json["id"],
    name: json["name"],
    isActive: json["is_active"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_active": isActive,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
