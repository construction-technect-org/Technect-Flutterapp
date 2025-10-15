class CategoryModel {
  bool? success;
  List<CategoryData>? data;
  String? message;

  CategoryModel({this.success, this.data, this.message});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<CategoryData>.from(json["data"]!.map((x) => CategoryData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class CategoryData {
  int? id;
  String? name;
  bool? isActive;
  int? sortOrder;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<SubCategory>? subCategories;

  CategoryData({
    this.id,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.subCategories,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["id"],
    name: json["name"],
    isActive: json["is_active"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subCategories: json["sub_categories"] == null
        ? []
        : List<SubCategory>.from(
            json["sub_categories"]!.map((x) => SubCategory.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_active": isActive,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "sub_categories": subCategories == null
        ? []
        : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
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
  String? image;
  String? mainCategoryName;
  List<ProductCategory>? products;

  SubCategory({
    this.id,
    this.mainCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.mainCategoryName,
    this.products,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    mainCategoryId: json["main_category_id"],
    name: json["name"],
    isActive: json["is_active"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    image: json["image"],
    mainCategoryName: json["main_category_name"],
    products: json["products"] == null
        ? []
        : List<ProductCategory>.from(
            json["products"]!.map((x) => ProductCategory.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main_category_id": mainCategoryId,
    "name": name,
    "is_active": isActive,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image": image,
    "main_category_name": mainCategoryName,
    "products": products == null
        ? []
        : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class ProductCategory {
  int? id;
  int? subCategoryId;
  String? name;
  bool? isActive;
  int? sortOrder;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? subCategoryName;
  List<Filter>? filters;
  String? image;

  ProductCategory({
    this.id,
    this.subCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.subCategoryName,
    this.filters,
    this.image,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["id"],
    subCategoryId: json["sub_category_id"],
    name: json["name"],
    isActive: json["is_active"],
    image: json["image"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subCategoryName: json["sub_category_name"],
    filters: json["filters"] == null
        ? []
        : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_category_id": subCategoryId,
    "name": name,
    "is_active": isActive,
    "image": image,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "sub_category_name": subCategoryName,
    "filters": filters == null ? [] : List<dynamic>.from(filters!.map((x) => x.toJson())),
  };
}

class Filter {
  int? id;
  int? productId;
  String? filterName;
  String? filterLabel;
  String? filterType;
  String? unit;
  String? minValue;
  String? maxValue;
  bool? isRequired;
  List<String>? dropdownList;
  String? productName;
  String? subCategoryName;
  String? mainCategoryName;

  Filter({
    this.id,
    this.productId,
    this.filterName,
    this.filterLabel,
    this.filterType,
    this.unit,
    this.minValue,
    this.maxValue,
    this.isRequired,
    this.dropdownList,
    this.productName,
    this.subCategoryName,
    this.mainCategoryName,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    id: json["id"],
    productId: json["product_id"],
    filterName: json["filter_name"],
    filterLabel: json["filter_label"],
    filterType: json["filter_type"],
    unit: json["unit"],
    minValue: json["min_value"],
    maxValue: json["max_value"],
    isRequired: json["is_required"],
    dropdownList: json["dropdown_list"] == null
        ? []
        : List<String>.from(json["dropdown_list"]!.map((x) => x)),
    productName: json["product_name"],
    subCategoryName: json["sub_category_name"],
    mainCategoryName: json["main_category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "filter_name": filterName,
    "filter_label": filterLabel,
    "filter_type": filterType,
    "unit": unit,
    "min_value": minValue,
    "max_value": maxValue,
    "is_required": isRequired,
    "dropdown_list": dropdownList == null
        ? []
        : List<dynamic>.from(dropdownList!.map((x) => x)),
    "product_name": productName,
    "sub_category_name": subCategoryName,
    "main_category_name": mainCategoryName,
  };
}
