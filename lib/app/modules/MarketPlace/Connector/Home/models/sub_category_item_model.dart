class SubCategoryItemResponse {
  final bool? success;
  final List<SubCategoryItem>? data;

  SubCategoryItemResponse({
    this.success,
    this.data,
  });

  factory SubCategoryItemResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoryItemResponse(
      success: json['success'],
      data: json['data'] != null
          ? List<SubCategoryItem>.from(
        json['data'].map(
              (x) => SubCategoryItem.fromJson(x),
        ),
      )
          : [],
    );
  }
}

class SubCategoryItem {
  final String? id;
  final String? subCategoryId;
  final String? name;
  final bool? isActive;
  final int? sortOrder;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubCategoryItem({
    this.id,
    this.subCategoryId,
    this.name,
    this.isActive,
    this.sortOrder,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) {
    return SubCategoryItem(
      id: json['id'],
      subCategoryId: json['subCategoryId'],
      name: json['name'],
      isActive: json['isActive'],
      sortOrder: json['sortOrder'],
      image: json['image'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subCategoryId': subCategoryId,
      'name': name,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'image': image,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
