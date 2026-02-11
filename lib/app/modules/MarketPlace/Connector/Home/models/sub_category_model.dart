class SubCategoryResponse {
  final bool success;
  final List<SubCategory> data;

  SubCategoryResponse({
    required this.success,
    required this.data,
  });

  factory SubCategoryResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoryResponse(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? List<SubCategory>.from(
        json['data'].map((x) => SubCategory.fromJson(x)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}

class SubCategory {
  final String id;
  final String categoryId;
  final String name;
  final bool isActive;
  final int sortOrder;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.isActive,
    required this.sortOrder,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? '',
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? '',
      isActive: json['isActive'] ?? false,
      sortOrder: json['sortOrder'] ?? 0,
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
