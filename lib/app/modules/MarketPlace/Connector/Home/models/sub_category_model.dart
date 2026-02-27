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
        (json['data'] as List)
            .map((x) => SubCategory.fromJson(x)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data.map((x) => x.toJson()).toList(),
  };
}

class SubCategory {
  final String id;
  final String categoryId;
  final String name;
  final bool isActive;
  final int sortOrder;
  final SubCategoryImage? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.isActive,
    required this.sortOrder,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? '',
      categoryId: json['categoryId'] ?? '',
      name: (json['name'] ?? '').toString().trim(),
      isActive: json['isActive'] ?? false,
      sortOrder: json['sortOrder'] ?? 0,
      image: json['image'] != null
          ? SubCategoryImage.fromJson(json['image'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryId': categoryId,
    'name': name,
    'isActive': isActive,
    'sortOrder': sortOrder,
    'image': image?.toJson(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}

class SubCategoryImage {
  final String? key;
  final String? url;
  final int? size;
  final String? contentType;
  final String? originalName;

  SubCategoryImage({
    this.key,
    this.url,
    this.size,
    this.contentType,
    this.originalName,
  });

  factory SubCategoryImage.fromJson(Map<String, dynamic> json) {
    return SubCategoryImage(
      key: json['key'],
      url: json['url'],
      size: json['size'],
      contentType: json['contentType'],
      originalName: json['originalName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'key': key,
    'url': url,
    'size': size,
    'contentType': contentType,
    'originalName': originalName,
  };
}