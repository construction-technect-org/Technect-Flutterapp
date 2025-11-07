class ProductModel {
  bool? success;
  List<CategoryProduct>? data;
  String? message;

  ProductModel({this.success, this.data, this.message});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    success: json['success'],
    message: json['message'],
    data: json['data'] == null
        ? []
        : List<CategoryProduct>.from(
            json['data'].map((x) => CategoryProduct.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CategoryProduct {
  int? id;
  int? subCategoryId;
  String? name;
  bool? isActive;
  int? sortOrder;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? subCategoryName;
  List<ProductSubCategory>? productSubCategories;

  CategoryProduct({
    this.id,
    this.subCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.subCategoryName,
    this.productSubCategories,
  });

  factory CategoryProduct.fromJson(Map<String, dynamic> json) =>
      CategoryProduct(
        id: json['id'],
        subCategoryId: json['sub_category_id'],
        name: json['name'],
        isActive: json['is_active'],
        sortOrder: json['sort_order'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        image: json['image'],
        subCategoryName: json['sub_category_name'],
        productSubCategories: json['product_sub_categories'] == null
            ? []
            : List<ProductSubCategory>.from(
                json['product_sub_categories'].map(
                  (x) => ProductSubCategory.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'sub_category_id': subCategoryId,
    'name': name,
    'is_active': isActive,
    'sort_order': sortOrder,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'image': image,
    'sub_category_name': subCategoryName,
    'product_sub_categories': productSubCategories == null
        ? []
        : List<dynamic>.from(productSubCategories!.map((x) => x.toJson())),
  };
}

class ProductSubCategory {
  int? id;
  int? subCategoryId;
  String? name;
  bool? isActive;
  int? sortOrder;

  ProductSubCategory({
    this.id,
    this.subCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
  });

  factory ProductSubCategory.fromJson(Map<String, dynamic> json) =>
      ProductSubCategory(
        id: json['id'],
        subCategoryId: json['sub_category_id'],
        name: json['name'],
        isActive: json['is_active'],
        sortOrder: json['sort_order'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'sub_category_id': subCategoryId,
    'name': name,
    'is_active': isActive,
    'sort_order': sortOrder,
  };
}
