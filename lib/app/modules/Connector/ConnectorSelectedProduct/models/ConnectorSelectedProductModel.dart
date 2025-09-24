class ConnectorSelectedProductModel {
  final bool success;
  final String message;
  final ConnectorSelectedProductData? data;

  ConnectorSelectedProductModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory ConnectorSelectedProductModel.fromJson(Map<String, dynamic> json) {
    return ConnectorSelectedProductModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ConnectorSelectedProductData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data?.toJson(),
    };
  }
}

class ConnectorSelectedProductData {
  final List<Product> products;
  final Pagination pagination;
  final Filters filters;

  ConnectorSelectedProductData({
    required this.products,
    required this.pagination,
    required this.filters,
  });

  factory ConnectorSelectedProductData.fromJson(Map<String, dynamic> json) {
    return ConnectorSelectedProductData(
      products: (json['products'] as List? ?? [])
          .map((e) => Product.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
      filters: Filters.fromJson(json['filters'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "products": products.map((e) => e.toJson()).toList(),
      "pagination": pagination.toJson(),
      "filters": filters.toJson(),
    };
  }
}

class Product {
  final int id;
  final String name;

  Product({
    required this.id,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalProducts;
  final int limit;
  final bool hasNext;
  final bool hasPrev;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalProducts,
    required this.limit,
    required this.hasNext,
    required this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      totalProducts: json['total_products'] ?? 0,
      limit: json['limit'] ?? 0,
      hasNext: json['has_next'] ?? false,
      hasPrev: json['has_prev'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "current_page": currentPage,
      "total_pages": totalPages,
      "total_products": totalProducts,
      "limit": limit,
      "has_next": hasNext,
      "has_prev": hasPrev,
    };
  }
}

class Filters {
  final List<ConnectorCategory> mainCategories;
  final List<ConnectorCategory> subCategories;
  final List<ConnectorCategory> categoryProducts;

  Filters({
    required this.mainCategories,
    required this.subCategories,
    required this.categoryProducts,
  });

  factory Filters.fromJson(Map<String, dynamic> json) {
    return Filters(
      mainCategories: (json['main_categories'] as List? ?? [])
          .map((e) => ConnectorCategory.fromJson(e))
          .toList(),
      subCategories: (json['sub_categories'] as List? ?? [])
          .map((e) => ConnectorCategory.fromJson(e))
          .toList(),
      categoryProducts: (json['category_products'] as List? ?? [])
          .map((e) => ConnectorCategory.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "main_categories": mainCategories.map((e) => e.toJson()).toList(),
      "sub_categories": subCategories.map((e) => e.toJson()).toList(),
      "category_products": categoryProducts.map((e) => e.toJson()).toList(),
    };
  }
}

class ConnectorCategory {
  final int id;
  final String name;
  final int productCount;

  ConnectorCategory({
    required this.id,
    required this.name,
    required this.productCount,
  });

  factory ConnectorCategory.fromJson(Map<String, dynamic> json) {
    return ConnectorCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      productCount: json['product_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "product_count": productCount,
    };
  }
}
