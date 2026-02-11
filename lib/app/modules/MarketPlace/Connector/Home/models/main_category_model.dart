class MainCategoryResponse {
  final bool? success;
  final List<MainCategory>? data;

  MainCategoryResponse({
    this.success,
    this.data,
  });

  factory MainCategoryResponse.fromJson(Map<String, dynamic> json) {
    return MainCategoryResponse(
      success: json['success'],
      data: json['data'] != null
          ? List<MainCategory>.from(
        json['data'].map((x) => MainCategory.fromJson(x)),
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

class MainCategory {
  final String? id;
  final String? moduleId;
  final String? name;
  final bool? isActive;
  final int? sortOrder;
  final String? createdAt;
  final String? updatedAt;
  final dynamic image;

  MainCategory({
    this.id,
    this.moduleId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    return MainCategory(
      id: json['id'],
      moduleId: json['moduleId'],
      name: json['name'],
      isActive: json['isActive'],
      sortOrder: json['sortOrder'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'moduleId': moduleId,
      'name': name,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'image': image,
    };
  }
}
