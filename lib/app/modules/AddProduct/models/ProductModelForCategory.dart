class ProductModel {
  final bool success;
  final List<Product> data;
  final String message;

  ProductModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => Product.fromJson(item))
              .toList() ??
          [],
      message: json['message'] ?? '',
    );
  }
}

class Product {
  final int id;
  final int subCategoryId;
  final String name;
  final bool isActive;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String subCategoryName;

  Product({
    required this.id,
    required this.subCategoryId,
    required this.name,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    required this.subCategoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      subCategoryId: json['sub_category_id'],
      name: json['name'] ?? '',
      isActive: json['is_active'] ?? false,
      sortOrder: json['sort_order'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      subCategoryName: json['sub_category_name'] ?? '',
    );
  }
}
