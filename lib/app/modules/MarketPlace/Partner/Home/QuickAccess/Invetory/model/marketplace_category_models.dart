// Models for Marketplace Category Hierarchy API responses
// Used for inventory creation dropdowns

// ─────────────────────────────────────────────────────
// Helper: extract a list from a response whose `data`
// may be a direct list OR a Map keyed by `key`.
// ─────────────────────────────────────────────────────
List<dynamic> _extractList(dynamic data, String key) {
  if (data == null) return [];
  if (data is List) return data; // flat array shape
  if (data is Map) {
    final inner = data[key];
    if (inner is List) return inner;
  }
  return [];
}

// ─────────────────────────────────────────────────────
// Module
// ─────────────────────────────────────────────────────
class MarketplaceModule {
  final String id;
  final String name;
  final String? description;
  final bool isActive;

  MarketplaceModule({
    required this.id,
    required this.name,
    this.description,
    required this.isActive,
  });

  factory MarketplaceModule.fromJson(Map<String, dynamic> json) => MarketplaceModule(
    id: json['id']?.toString() ?? '',
    name: json['name'] ?? '',
    description: json['description'],
    isActive: json['isActive'] ?? json['is_active'] ?? true,
  );
}

class MarketplaceModuleResponse {
  final bool success;
  final List<MarketplaceModule> data;

  MarketplaceModuleResponse({required this.success, required this.data});

  factory MarketplaceModuleResponse.fromJson(Map<String, dynamic> json) =>
      MarketplaceModuleResponse(
        success: json['success'] ?? false,
        // API returns: { data: { modules: [...] } }
        data: List<MarketplaceModule>.from(
          _extractList(json['data'], 'modules').map((x) => MarketplaceModule.fromJson(x)),
        ),
      );
}

// ─────────────────────────────────────────────────────
// Main Category
// ─────────────────────────────────────────────────────
class MarketplaceMainCategory {
  final String id;
  final String name;
  final String? moduleId;
  final bool isActive;

  MarketplaceMainCategory({
    required this.id,
    required this.name,
    this.moduleId,
    required this.isActive,
  });

  factory MarketplaceMainCategory.fromJson(Map<String, dynamic> json) => MarketplaceMainCategory(
    id: json['id']?.toString() ?? '',
    name: json['name'] ?? '',
    moduleId: json['moduleId']?.toString() ?? json['module_id']?.toString(),
    isActive: json['isActive'] ?? json['is_active'] ?? true,
  );
}

class MarketplaceMainCategoryResponse {
  final bool success;
  final List<MarketplaceMainCategory> data;

  MarketplaceMainCategoryResponse({required this.success, required this.data});

  factory MarketplaceMainCategoryResponse.fromJson(Map<String, dynamic> json) =>
      MarketplaceMainCategoryResponse(
        success: json['success'] ?? false,
        // API may return: { data: { mainCategories: [...] } } or { data: [...] }
        data: List<MarketplaceMainCategory>.from(
          _extractList(
            json['data'],
            'mainCategories',
          ).map((x) => MarketplaceMainCategory.fromJson(x)),
        ),
      );
}

// ─────────────────────────────────────────────────────
// Category
// ─────────────────────────────────────────────────────
class MarketplaceCategory {
  final String id;
  final String name;
  final String? mainCategoryId;
  final bool isActive;

  MarketplaceCategory({
    required this.id,
    required this.name,
    this.mainCategoryId,
    required this.isActive,
  });

  factory MarketplaceCategory.fromJson(Map<String, dynamic> json) => MarketplaceCategory(
    id: json['id']?.toString() ?? '',
    name: json['name'] ?? '',
    mainCategoryId: json['mainCategoryId']?.toString() ?? json['main_category_id']?.toString(),
    isActive: json['isActive'] ?? json['is_active'] ?? true,
  );
}

class MarketplaceCategoryResponse {
  final bool success;
  final List<MarketplaceCategory> data;

  MarketplaceCategoryResponse({required this.success, required this.data});

  factory MarketplaceCategoryResponse.fromJson(Map<String, dynamic> json) =>
      MarketplaceCategoryResponse(
        success: json['success'] ?? false,
        // API may return: { data: { categories: [...] } } or { data: [...] }
        data: List<MarketplaceCategory>.from(
          _extractList(json['data'], 'categories').map((x) => MarketplaceCategory.fromJson(x)),
        ),
      );
}

// ─────────────────────────────────────────────────────
// Sub Category
// ─────────────────────────────────────────────────────
class MarketplaceSubCategory {
  final String id;
  final String name;
  final String? categoryId;
  final bool isActive;

  MarketplaceSubCategory({
    required this.id,
    required this.name,
    this.categoryId,
    required this.isActive,
  });

  factory MarketplaceSubCategory.fromJson(Map<String, dynamic> json) => MarketplaceSubCategory(
    id: json['id']?.toString() ?? '',
    name: json['name'] ?? '',
    categoryId: json['categoryId']?.toString() ?? json['category_id']?.toString(),
    isActive: json['isActive'] ?? json['is_active'] ?? true,
  );
}

class MarketplaceSubCategoryResponse {
  final bool success;
  final List<MarketplaceSubCategory> data;

  MarketplaceSubCategoryResponse({required this.success, required this.data});

  factory MarketplaceSubCategoryResponse.fromJson(Map<String, dynamic> json) =>
      MarketplaceSubCategoryResponse(
        success: json['success'] ?? false,
        // API may return: { data: { subCategories: [...] } } or { data: [...] }
        data: List<MarketplaceSubCategory>.from(
          _extractList(
            json['data'],
            'subCategories',
          ).map((x) => MarketplaceSubCategory.fromJson(x)),
        ),
      );
}

// ─────────────────────────────────────────────────────
// Category Product
// ─────────────────────────────────────────────────────
class MarketplaceCategoryProduct {
  final String id;
  final String name;
  final String? subCategoryId;
  final bool isActive;

  MarketplaceCategoryProduct({
    required this.id,
    required this.name,
    this.subCategoryId,
    required this.isActive,
  });

  factory MarketplaceCategoryProduct.fromJson(Map<String, dynamic> json) =>
      MarketplaceCategoryProduct(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? '',
        subCategoryId: json['subCategoryId']?.toString() ?? json['sub_category_id']?.toString(),
        isActive: json['isActive'] ?? json['is_active'] ?? true,
      );
}

class MarketplaceCategoryProductResponse {
  final bool success;
  final List<MarketplaceCategoryProduct> data;

  MarketplaceCategoryProductResponse({required this.success, required this.data});

  factory MarketplaceCategoryProductResponse.fromJson(Map<String, dynamic> json) =>
      MarketplaceCategoryProductResponse(
        success: json['success'] ?? false,
        // API may return: { data: { categoryProducts: [...] } } or { data: [...] }
        data: List<MarketplaceCategoryProduct>.from(
          _extractList(
            json['data'],
            'categoryProducts',
          ).map((x) => MarketplaceCategoryProduct.fromJson(x)),
        ),
      );
}
