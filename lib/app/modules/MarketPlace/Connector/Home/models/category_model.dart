class CategoryResponse {
  final bool? success;
  final List<CCategory>? data;
  CategoryResponse({
    this.success,
    this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      success: json['success'],
      data: json['data'] != null
          ? List<CCategory>.from(
        json['data'].map((x) => CCategory.fromJson(x)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class CCategory {
  final String? id;
  final String? mainCategoryId;
  final String? name;
  final bool? isActive;
  final int? sortOrder;
  final dynamic image;
  final String? createdAt;
  final String? updatedAt;

  CCategory({
    this.id,
    this.mainCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory CCategory.fromJson(Map<String, dynamic> json) {
    return CCategory(
      id: json['id'],
      mainCategoryId: json['mainCategoryId'],
      name: json['name'],
      isActive: json['isActive'],
      sortOrder: json['sortOrder'],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mainCategoryId': mainCategoryId,
      'name': name,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
